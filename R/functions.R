#' Classify Open Street Map Features
#'
#' An R package to classify Open Street Map (OSM) features into meaningful functional or analytical categories.
#' It expects OSM PBF data, e.g. from https://download.geofabrik.de/, imported as data frames (e.g. using \emph{sf}), and
#' is well optimized to deal with large quantities of OSM data. \cr\cr
#'
#' @section Functions:
#' Main Function to Classify OSM Features
#'
#' \code{\link[=osm_classify]{osm_classify()}}
#'
#' Auxiliary Functions to Extract Information (Tags) from OSM PBF Layers
#'
#' \code{\link[=osm_other_tags_list]{osm_other_tags_list()}}\cr
#' \code{\link[=osm_tags_df]{osm_tags_df()}}\cr\cr
#'
#' @section Classifications:
#' A Classification of OSM Features by Economic Function, developed for the Africa OSM following Krantz (2023)
#'
#' \code{\link{osm_point_polygon_class}}\cr
#' \code{\link{osm_line_class}}\cr
#' \code{\link{osm_line_info_tags}}
#'
#' @references
#' Krantz, Sebastian, Mapping Africa’s Infrastructure Potential with Geospatial Big Data, Causal ML, and XAI (August 10, 2023). Available at SSRN: https://www.ssrn.com/abstract=4537867
#'
#' @examples
#' \dontrun{
#' # Download OSM PBF file for Djibouti
#' download.file("https://download.geofabrik.de/africa/djibouti-latest.osm.pbf",
#'               destfile = "djibouti-latest.osm.pbf", mode = "wb")
#'
#' # Import OSM data for Djibouti
#' library(sf)
#' st_layers("djibouti-latest.osm.pbf")
#' points <- st_read("djibouti-latest.osm.pbf", "points")
#' lines <- st_read("djibouti-latest.osm.pbf", "lines")
#' polygons <- st_read("djibouti-latest.osm.pbf", "multipolygons")
#'
#' # Classify features
#' library(osmclass)
#' points_class <- osm_classify(points, osm_point_polygon_class)
#' polygons_class <- osm_classify(polygons, osm_point_polygon_class)
#' lines_class <- osm_classify(lines, osm_line_class)
#'
#' # See what proportion of the data we have classified
#' sum(points_class$classified)/nrow(points)
#' sum(polygons_class$classified)/nrow(polygons)
#' sum(lines_class$classified)/nrow(lines)
#'
#' # Get some additional info for lines
#' library(collapse)
#' lines_info <- lines |> ss(lines_class$classified) |>
#'   rsplit(lines_class$main_cat[lines_class$classified]) |>
#'   get_vars(names(osm_line_info_tags), regex = TRUE)
#'
#' lines_info <- Map(osm_tags_df, lines_info, osm_line_info_tags[names(lines_info)])
#' str(lines_info)
#'
#' # Get 'other_tags' of points layer as list
#' other_point_tags <- osm_other_tags_list(points$other_tags, values = TRUE)
#' str(other_point_tags)
#'
#'
#'
#' # TIP: For larger OSM files, importing layers (esp. lines and polygons) at once
#' # may not be feasible memory-wise. In this case, translating to GPKG and using
#' # an SQL query for stepwise processing is helpful:
#'
#' library(fastverse)
#' library(sf)
#'
#' # Get all Africa OSM (6 Gb)
#' opt <- options(timeout = 6000)
#' download.file("https://download.geofabrik.de/africa-latest.osm.pbf",
#'               destfile = "africa-latest.osm.pbf", mode = "wb")
#'
#' # GPKG is large (> 40 Gb)
#' gdal_utils("vectortranslate", "africa-latest.osm.pbf", "africa-latest.gpkg")
#'
#' # Get map layers: shows how many features per layer
#' layers <- st_layers("africa-latest.gpkg")
#' print(layers)
#'
#' # Example: stepwise classifying lines, 1M features at a time
#' N <- layers$features[layers$name == "lines"]
#' int <- seq(0L, N, 1e6L)
#' lines_class <- vector("list", length(int))
#'
#' for (i in seq_len(length(int))) {
#'   cat("\nReading Lines Chunk:", i, "\n")
#'   temp = st_read("africa-latest.gpkg",
#'                  query = paste("SELECT * FROM lines LIMIT 1000000 OFFSET", int[i]))
#'   # Some pre-selection: removing residential roads
#'   temp %<>% fsubset(is.na(highway) | highway %chin% osm_line_class$road$highway)
#'   # Classifying
#'   temp_class <- osm_classify(temp, osm_line_class)
#'   lines_class[[i]] <- ss(temp_class, temp_class$classified, check = FALSE)
#' }
#'
#' # Combining
#' lines_class <- rbindlist(lines_class)
#' options(opt)
#'}
#'
#' @docType package
#' @name osmclass-package
#' @aliases osmclass
#'
#' @importFrom data.table %chin%
#' @importFrom collapse vlengths .c setv alloc fnobs fnrow %-=% qDT whichv whichNA add_vars add_vars<- colorder anyv
#' @importFrom stringi stri_detect_fixed stri_extract_first_regex
NULL


# Functions to explore other tags column

#' Generate a List from the 'other_tags' Column in OSM PBF Data
#' @param x character. The 'other_tags' column of an imported osm.pbf file.
#' @param values logical. \code{TRUE} also includes the values of tags.
#' @param split character. Pattern passed to \code{\link{strsplit}} to split up \code{x}.
#' @param \dots further arguments to \code{\link{strsplit}}.
#'
#' @returns a list of tags as character vectors, or a nested list of tags and values if \code{values = TRUE}.
#' @seealso \link{osmclass-package}
#' @examples
#' # See Examples at ?osmclass for full examples
#'
#' # Extract 'other_tags' as list
#' other_tags <- osm_other_tags_list(djibouti_points$other_tags)
#' other_tags[1:10]
#'
#' # Count frequency (showing top 10)
#' sort(table(unlist(other_tags)), decreasing = TRUE)[1:10]
#'
#' # Also include values
#' other_tags_values <- osm_other_tags_list(djibouti_points$other_tags, values = TRUE)
#' other_tags_values[1:10]
#'
#' @export
osm_other_tags_list <- function(x, values = FALSE, split = '","|"=>"', ...) {
  if(!is.character(x)) stop("x needs to be an 'other_tags' column with OSM PBF formatting")
  if(values) {
    xx = substr(x, 2L, vlengths(x) %-=% 1L)
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
  return(res)
}

#' Extract Tags as Columns from an OSM PBF Layer
#' @param data an imported layer from an OSM PBF file. Usually has a few important tags already expanded as columns, and an 'other_tags' column which compounds less frequent tags as character strings.
#' @param tags character. A vector of tags to extract as columns.
#' @param na.prop double. Proportion of features having a tag in order to keep the column.
#'
#' @returns a \emph{data.table} with the supplied \code{tags} as columns, and the same number of rows as the input frame.
#' @seealso \link{osmclass-package}
#' @examples
#' # See Examples at ?osmclass for full examples
#'
#' # Extracting tags of interest (some of which are inside 'other_tags')
#' tags <- c("osm_id", "highway", "man_made", "name", "alt_name",
#'           "description", "wikidata", "amenity", "tourism")
#' head(osm_tags_df(djibouti_points, tags))
#'
#' # Only keeping tags with at least 5\% non-missing
#' head(osm_tags_df(djibouti_points, tags, na.prop = 0.05))
#'
#' @export
osm_tags_df <- function(data, tags, na.prop = 0) {
  n <- fnrow(data)
  if(!is.character(tags)) stop("tags needs to be a character vector")
  res <- .subset(data, names(data) %in% tags)
  if(length(res)) {
    if(any(miss <- fnobs(res) < n * na.prop)) res <- res[!miss]
    oth_tg <- setdiff(tags, names(res))
  } else oth_tg <- tags
  other_tags <- data$other_tags
  if(is.null(other_tags)) stop("data needs to have other_tags column with OSM PBF formatting")
  if(length(other_tags) && length(oth_tg)) {
    for (tag in oth_tg) {
      tag_str <- paste0('"', tag, '"=>')
      has_tag <- which(stri_detect_fixed(other_tags, tag_str)) # which removes missing values...
      if(length(has_tag) == 0L || length(has_tag) < n * na.prop) next
      tag_value <- stri_extract_first_regex(other_tags[has_tag], paste0(tag_str, '".*?"'))
      tag_value <- substr(tag_value, nchar(tag_str) + 2L, vlengths(tag_value) %-=% 1L)
      res_tag <- alloc(NA_character_, n)
      setv(res_tag, has_tag, tag_value, vind1 = TRUE)
      res[[tag]] <- res_tag
    }
  }
  if(length(res)) return(qDT(res[tags[tags %in% names(res)]]))
  return(NULL)
}


which_tag_values <- function(tag_value, value) {
  if(length(value) > 1L) {
    neg <- startsWith(value, "!")
    if(any(neg)) {
      if(!all(neg)) stop('Tag values need to be either all positive or all negative or "" to match all values')
      return(whichv(is.na(tag_value) | tag_value %chin% substr(value, 2L, 1000L), FALSE))
    }
    return(which(tag_value %chin% value)) # TODO: subset non-missing first increases performance??
  }
  if(value == "") return(whichNA(tag_value, invert = TRUE)) # This is if all values of the tag are matched
  if(startsWith(value, "!")) return(which(tag_value != substr(value, 2L, 1000L))) # cannot use whichv() because need to skip NAs
  whichv(tag_value, value)
}

#' Classify OSM Features
#'
#' Classifies OSM features into meaningful functional or analytical categories, according to a supplied classification.
#' @param data imported layer from an OSM PBF file. Usually an 'sf' data frame, but the geometry column is unnecessary. Importantly, the data frame should have an 'other_tags' column with OSM PBF formatting.
#' @param classification a 2-level nested list providing a classification. The layers of the list are:
#' \tabular{lll}{
#'   \emph{categories} \tab\tab a list of tags and matched values that constitute a feature category. \cr\cr\cr
#'   \emph{tags} \tab\tab a character vector of tag values to match, or \code{""} to match all possible values.
#'   It is also possible to match all except certain tags by negating them with \code{"!"} e.g. \code{"!no"}.
#'   Obviously, it is not sensible to mix negation with other specifications. \cr
#' }
#' See \code{\link{osm_point_polygon_class}} and \code{\link{osm_line_class}} for example classifications.
#' @note
#' It is not necessary to expand the 'other_tags' column, e.g. using \code{\link[=osm_tags_df]{osm_tags_df()}}. \code{osm_classify()} efficiently searches the content of that column without expanding it.
#'
#' @returns
#'  a \emph{data.table} with rows matching the input frame and columns
#'  \item{classified}{logical. Whether the feature was classified i.e. matched by any tag-value in the \code{classification}. }
#'  \item{main_cat}{character. The first category the feature was assigned to, depending on the order of categories in the \code{classification}. }
#'  \item{main_tag}{character. The tag matched for the main category. }
#'  \item{main_tag_value}{character. The value matched on. }
#'  \item{alt_cats}{character. Alternative (secondary) categories assigned, comma-separated if multiple. }
#'  \item{alt_tags_values}{character. The tags and double-quoted values matched for secondary categories, comma-separated if multiple.}
#' @seealso \link{osmclass-package}
#' @examples
#' # See Examples at ?osmclass for a full examples
#'
#' # Classify OSM Points in Djibouti
#' djibouti_points_class <- osm_classify(djibouti_points, osm_point_polygon_class)
#' head(djibouti_points_class)
#' collapse::descr(djibouti_points_class)
#' @export
osm_classify <- function(data, classification) {

  n <- fnrow(data)
  nam <- names(data)
  if(is.null(nam) || anyDuplicated(nam)) stop("data needs to be uniquely named")
  # Need separate allocations, because setv modifies by reference
  class_res <- list(main_cat = alloc(NA_character_, n),
                    main_tag = alloc(NA_character_, n),
                    main_tag_value = alloc(NA_character_, n),
                    alt_cats = character(n),
                    alt_tags_values = character(n))
  other_tags <- data$other_tags
  if(is.null(other_tags)) stop("data needs to have 'other_tags' column with OSM PBF formatting")
  classified <- logical(n)
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
        has_tag <- which_tag_values(tag_value, value)
      } else { # If the tag is stored in other_tags
        tag_str <- paste0('"', tag, '"=>')
        has_tag <- which(stri_detect_fixed(other_tags, tag_str)) # which removes missing values...
        if(length(has_tag) == 0L) next
        tag_value <- stri_extract_first_regex(other_tags[has_tag], paste0(tag_str, '".*?"'))
        tag_value <- substr(tag_value, nchar(tag_str) + 2L, vlengths(tag_value) %-=% 1L)
        if(!(length(value) == 1L && value == "")) {  # If the tag has specific values to be matched
          matches <- which_tag_values(tag_value, value)
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
                  paste0(class_res[[5L]][has_tag_class], ", ", tag, ':"',
                         if(length(tag_value) == n) tag_value[has_tag_class] else tag_value[class_has_tag], '"')), vind1 = TRUE)
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
