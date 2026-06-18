# Classify Open Street Map Features

An R package to classify Open Street Map (OSM) features into meaningful
functional or analytical categories. It expects OSM PBF data, e.g. from
https://download.geofabrik.de/, imported as data frames (e.g. using
*sf*), and is well optimized to deal with large quantities of OSM
data.  
  

## Functions

Main Function to Classify OSM Features

[`osm_classify()`](https://sebkrantz.github.io/osmclass/reference/osm_classify.md)

Auxiliary Functions to Extract Information (Tags) from OSM PBF Layers

[`osm_other_tags_list()`](https://sebkrantz.github.io/osmclass/reference/osm_other_tags_list.md)  
[`osm_other_tags_str()`](https://sebkrantz.github.io/osmclass/reference/osm_other_tags_str.md)  
[`osm_tags_df()`](https://sebkrantz.github.io/osmclass/reference/osm_tags_df.md)  
  

## Classifications

A Classification of OSM Features by Economic Function, developed for the
Africa OSM following Krantz (2023)

[`osm_point_polygon_class`](https://sebkrantz.github.io/osmclass/reference/classifications.md)  
[`osm_line_class`](https://sebkrantz.github.io/osmclass/reference/classifications.md)  
[`osm_line_info_tags`](https://sebkrantz.github.io/osmclass/reference/classifications.md)

## References

Krantz, Sebastian, Mapping Africa’s Infrastructure Potential with
Geospatial Big Data, Causal ML, and XAI (August 10, 2023). Available at
SSRN: https://www.ssrn.com/abstract=4537867

## Examples

``` r
if (FALSE) { # \dontrun{
# Download OSM PBF file for Djibouti
download.file("https://download.geofabrik.de/africa/djibouti-latest.osm.pbf",
              destfile = "djibouti-latest.osm.pbf", mode = "wb")

# Import OSM data for Djibouti
library(sf)
st_layers("djibouti-latest.osm.pbf")
points <- st_read("djibouti-latest.osm.pbf", "points")
lines <- st_read("djibouti-latest.osm.pbf", "lines")
polygons <- st_read("djibouti-latest.osm.pbf", "multipolygons")

# Classify features
library(osmclass)
points_class <- osm_classify(points, osm_point_polygon_class)
polygons_class <- osm_classify(polygons, osm_point_polygon_class)
lines_class <- osm_classify(lines, osm_line_class)

# See what proportion of the data we have classified
sum(points_class$classified)/nrow(points)
sum(polygons_class$classified)/nrow(polygons)
sum(lines_class$classified)/nrow(lines)

# Get some additional info for lines
library(collapse)
lines_info <- lines |> ss(lines_class$classified) |>
  rsplit(lines_class$main_cat[lines_class$classified]) |>
  get_vars(names(osm_line_info_tags), regex = TRUE)

lines_info <- Map(osm_tags_df, lines_info, osm_line_info_tags[names(lines_info)])
str(lines_info)

# Get 'other_tags' of points layer as list
other_point_tags <- osm_other_tags_list(points$other_tags, values = TRUE)
str(other_point_tags)



# TIP: For larger OSM files, importing layers (esp. lines and polygons) at once
# may not be feasible memory-wise. In this case, translating to GPKG and using
# an SQL query for stepwise processing is helpful:

library(fastverse)
library(sf)

# Get all Africa OSM (6 Gb)
opt <- options(timeout = 6000)
download.file("https://download.geofabrik.de/africa-latest.osm.pbf",
              destfile = "africa-latest.osm.pbf", mode = "wb")

# GPKG is large (> 40 Gb)
gdal_utils("vectortranslate", "africa-latest.osm.pbf", "africa-latest.gpkg")

# Get map layers: shows how many features per layer
layers <- st_layers("africa-latest.gpkg")
print(layers)

# Example: stepwise classifying lines, 1M features at a time
N <- layers$features[layers$name == "lines"]
int <- seq(0L, N, 1e6L)
lines_class <- vector("list", length(int))

for (i in seq_len(length(int))) {
  cat("\nReading Lines Chunk:", i, "\n")
  temp = st_read("africa-latest.gpkg",
                 query = paste("SELECT * FROM lines LIMIT 1000000 OFFSET", int[i]))
  # Some pre-selection: removing residential roads
  temp %<>% fsubset(is.na(highway) | highway %chin% osm_line_class$road$highway)
  # Classifying
  temp_class <- osm_classify(temp, osm_line_class)
  lines_class[[i]] <- ss(temp_class, temp_class$classified, check = FALSE)
}

# Combining
lines_class <- rbindlist(lines_class)
options(opt)
} # }
```
