# osmclass

**Functions to classify Open Street Map (OSM) features into meaningful functional or analytical categories**

<!-- badges: start -->
[![R-CMD-check](https://github.com/SebKrantz/osmclass/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/SebKrantz/osmclass/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Designed for OSM PBF files, e.g. from <https://download.geofabrik.de/>, imported as spatial data frames using `sf::st_read()`. A classification consists of a list of categories which are related to certain OSM tags and values, also specified as a list. Given a layer from an OSM PBF file and a classification, the main `osm_classify()` function returns a classification data frame giving, for each feature, the primary and alternative categories (if there is overlap), and the tag(s) and value(s) matched on. The package also contains a suggested classification of point/polygon features into 33 economically meaningful categories, and of lines into 11 categories, based on <Krantz (2023)>


### Usage Example
```r
# Download OSM PBF file for Djibouti
download.file("https://download.geofabrik.de/africa/djibouti-latest.osm.pbf", 
              destfile = "djibouti-latest.osm.pbf", mode = "wb")
              
# Import OSM data for Djibouti
library(sf)
st_layers("djibouti-latest.osm.pbf")
points <- st_read("djibouti-latest.osm.pbf", "points")
lines <- st_read("djibouti-latest.osm.pbf", "lines")
polygons <- st_read("djibouti-latest.osm.pbf", "multipolygons")

# Classify features using the included classifications
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

```
