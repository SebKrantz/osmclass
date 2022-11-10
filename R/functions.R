#' Classify OSM Features
#' @noRd
#' @importFrom data.table %chin%
#' @importFrom collapse .c setv alloc fnobs fnrow %-=% qDT whichNA add_vars add_vars<- colorder anyv
#' @importFrom stringi stri_detect_fixed stri_extract_first_regex
NULL

# Functions to explore other tags column

#' Generate list of 'other_tags' Column in OSM PBF Data
#' @param x character. The 'other_tags' column of an imported osm.pbf file.
#' @param values logical. \code{TRUE} also includes the values of tags.
#' @param split character. Pattern passed to \code{\link{strsplit}} to split up \code{x}.
#' @param \dots further arguments to \code{\link{strsplit}}.
#' @export
osm_other_tags_list <- function(x, values = FALSE, split = '","|"=>"', ...) {
  if(values) {
    xx = substr(x, 2L, nchar(x) - 1L)
    x_spl = strsplit(xx, split, ...)
    res = lapply(x_spl, function(x) {
      n = length(x)
      if(n == 0L || (n == 1L && is.na(x))) return(NULL)
      ind = 1L:(n/2L) * 2L
      r = as.vector(x[ind], "list")
      names(r) = x[ind - 1L]
      r
    })
  } else {
    xx = substr(x, 2L, 10000L)
    x_spl = strsplit(xx, split, ...)
    res = lapply(x_spl, function(x) {
      n = length(x)
      if(n == 0L || (n == 1L && is.na(x))) return(NULL)
      x[1L:(n/2L) * 2L - 1L]
    })
  }
}

#' Extract Tags and Values as Columns from an OSM PBF Data
#' @param data an imported layer from an OSM PBF file.
#' @param tags character. A vector of tags to extract as columns.
#' @param na.prop double. Proportion of features having a tag in order to keep the column.
#' @export
osm_tags_df <- function(data, tags, na.prop = 0) {
  n <- fnrow(data)
  res <- .subset(data, names(data) %in% tags)
  if(length(res)) {
    if(any(miss <- fnobs(res) < n * na.prop)) res <- res[!miss]
    oth_tg <- setdiff(tags, names(res))
  } else oth_tg <- tags
  other_tags <- data$other_tags
  if(length(other_tags) && length(oth_tg)) {
    for (tag in oth_tg) {
      tag_str <- paste0('"', tag, '"=>')
      has_tag <- which(stri_detect_fixed(other_tags, tag_str)) # which removes missing values...
      if(length(has_tag) == 0L || length(has_tag) < n * na.prop) next
      tag_value <- stri_extract_first_regex(other_tags[has_tag], paste0(tag_str, '".*?"'))
      tag_value <- substr(tag_value, nchar(tag_str) + 2L, nchar(tag_value) %-=% 1L)
      res_tag <- alloc(NA_character_, n)
      setv(res_tag, has_tag, tag_value, vind1 = TRUE)
      res[[tag]] <- res_tag
    }
  }
  if(length(res)) return(qDT(res[tags[tags %in% names(res)]]))
  return(NULL)
}


#' Classify OSM Features
#' @param data imported layer from an OSM PBF file.
#' @param classification a 2-level nested list providing a classification. The layers of the list are:
#' \tabular{ll}{
#'   categories \tab a list of tags and values that make up a feature category \cr
#'   tags \tab a character vector of tag values to match on, or \code{""} to match all possible tags
#' }
#' @examples
#' str(osm_line_class)
#' str(osm_point_polygon_class)
#' @export
osm_classify <- function(data, classification) {

  n <- fnrow(data)
  nam <- names(data)
  if(is.null(nam) || anyDuplicated(nam)) stop("data needs to be uniquely named")
  # Need separate allocations, because setv modifies by reference
  class_res <- list(main_cat = alloc(NA_character_, n),
                    main_tag = alloc(NA_character_, n),
                    main_tag_value = alloc(NA_character_, n),
                    alt_cats = alloc("", n),
                    alt_tags_values = alloc("", n))
  other_tags <- data$other_tags
  if(is.null(other_tags)) stop("data needs to have other_tags column with OSM formatting")
  classified <- alloc(FALSE, n)
  nam_class <- names(classification)
  if(!is.list(classification) || is.null(nam_class)) stop("classification needs to be a named list of categories")

  # Iteration over categories
  for(k in seq_along(classification)) {
    cat <- nam_class[k] # Needed, as nam_class can have duplicate values...
    category <- classification[[k]]
    nam_cat <- names(category)
    if(!is.list(category) || is.null(nam_cat)) stop("each item in classification needs to be a named list of tags, with character values or empty string ('') indicating all values")
    # Iteration over tags
    for(t in seq_along(category)) {
      tag <- nam_cat[t] # Needed, as nam_cat can have duplicate values...
      value <- category[[t]]
      if(!is.character(value)) stop("tag values need to be character strings")

      if(anyv(nam, tag)) { # If the tag has a separate column
        tag_value <- .subset2(data, tag)
        has_tag <- if(length(value) == 1L && value == "") # This is if all values of the tag are matched
          whichNA(tag_value, invert = TRUE) else
            which(tag_value %chin% value) # TODO: subset first increases performance??
      } else { # If the tag is stored in other_tags
        tag_str <- paste0('"', tag, '"=>')
        has_tag <- which(stri_detect_fixed(other_tags, tag_str)) # which removes missing values...
        if(length(has_tag) == 0L) next
        tag_value <- stri_extract_first_regex(other_tags[has_tag], paste0(tag_str, '".*?"'))
        tag_value <- substr(tag_value, nchar(tag_str) + 2L, nchar(tag_value) %-=% 1L)
        if(!(length(value) == 1L && value == "")) {  # If the tag has specific values to be matched
          matches <- tag_value %chin% value
          has_tag <- has_tag[matches]
          tag_value <- tag_value[matches]
        }
      }
      # Now storing the results
      if(length(has_tag) == 0L) next
      class_has_tag <- which(classified[has_tag])
      if(length(class_has_tag) == 0L) { # This is easy, no corresponding items classified yet
        setv(class_res[1:3], has_tag, list(cat, tag, tag_value), vind1 = TRUE)
      } else { # If some are already classified, need to store this information in the _alt columns
        has_tag_not_class <- has_tag[-class_has_tag] # These are the unclassified ones
        if(length(has_tag_not_class)) setv(class_res[1:3], has_tag_not_class,
                                           list(cat, tag, if(length(tag_value) == n) tag_value else tag_value[-class_has_tag]), vind1 = TRUE)
        has_tag_class <- has_tag[class_has_tag] # These are the already classified ones
        setv(class_res[4:5], has_tag_class,
             list(paste(class_res[[4L]][has_tag_class], cat, sep = ", "), # Would be great to be able to do this by reference.
                  paste0(class_res[[5L]][has_tag_class], ", ", tag, ":'",
                         if(length(tag_value) == n) tag_value[has_tag_class] else tag_value[class_has_tag], "'")), vind1 = TRUE)
      }
      setv(classified, has_tag, TRUE, vind1 = TRUE)
    }
  }
  class_res[4:5] <- setv(lapply(class_res[4:5], substr, 3L, 1000L), "", NA_character_)
  add_vars(class_res, "front") <- classified
  return(qDT(class_res))
}

# Experimental stuff...

# Stingfish is lower than stringi for these tasks
# library(stringfish)
# other_tags_sf <- convert_to_sf(other_tags)
# system.time(sf_grepl(other_tags_sf, tag_str, fixed = TRUE))

# has_tag <- grep(tag_str, other_tags, fixed = TRUE)
# tag_list <- other_tags_to_list(other_tags[has_tag]) # TODO: This is expensive: smarter way to do his??
# sub(paste0('"', tag, '"=>"(.*)"'), '\\1', other_tags[has_tag])

# stri_replace_first_fixed(other_tags[has_tag], tag_str, sub("=>", ":", tag_str))
#
# system.time(unlist(lapply(other_tags_to_list(other_tags[has_tag]), .subset2, "shop")))
# system.time(stri_extract_first_regex(other_tags[has_tag], paste0("(?<=", tag_str, '")(.*?)(?=")'))) # This is correct, but slow !!!
# system.time(stri_extract_first_regex(other_tags[has_tag], paste0(tag_str, '"(.*?)"')))
# system.time(stri_extract_first_regex(other_tags[has_tag], paste0(tag_str, '".*?"')))
# system.time(stri_extract_first_regex(other_tags[has_tag], paste0("(?<=",tag_str, '")(.*?)(")')))
# stri_extract_first_regex(other_tags[has_tag], paste0(tag_str, '"[\\s\\S]*?"'))
