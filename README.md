# osmclass

**Functions to classify Open Street Map (OSM) features into meaningful functional or analytical categories**

<!-- badges: start -->
[![R-CMD-check](https://github.com/SebKrantz/osmclass/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/SebKrantz/osmclass/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Designed for OSM PBF files, e.g. from <https://download.geofabrik.de/>, imported as spatial data frames using `sf::st_read()`. A classification consists of a list of categories that are assigned to certain OSM tags and values, also specified as a list. Given a layer from an OSM PBF file and a classification, the main `osm_classify()` function returns a classification data frame giving, for each feature, the primary and alternative categories (if there is overlap) assigned, and the tag(s) and value(s) matched on. The package also contains a classification of OSM features by economic function, based on [Krantz (2023)](https://www.ssrn.com/abstract=4537867). 
    
Krantz, Sebastian, Mapping Africa’s Infrastructure Potential with Geospatial Big Data, Causal ML, and XAI (August 10, 2023). Available at SSRN: https://www.ssrn.com/abstract=4537867    
    


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

### Executed Example

``` r
options(width = 200)
# Download OSM PBF file for Djibouti
download.file("https://download.geofabrik.de/africa/djibouti-latest.osm.pbf", 
              destfile = "djibouti-latest.osm.pbf", mode = "wb")

# Import Data
library(sf)
#> Linking to GEOS 3.11.0, GDAL 3.5.3, PROJ 9.1.0; sf_use_s2() is TRUE
st_layers("djibouti-latest.osm.pbf")
#> Driver: OSM 
#> Available layers:
#>         layer_name       geometry_type features fields crs_name
#> 1           points               Point       NA     10   WGS 84
#> 2            lines         Line String       NA     10   WGS 84
#> 3 multilinestrings   Multi Line String       NA      4   WGS 84
#> 4    multipolygons       Multi Polygon       NA     25   WGS 84
#> 5  other_relations Geometry Collection       NA      4   WGS 84
points <- st_read("djibouti-latest.osm.pbf", "points")
#> Reading layer `points' from data source `/private/var/folders/zp/cc61fbb560g9pqns4g2wtzz40000gn/T/RtmpYmbUJM/reprex-162c639d7c992-smoky-macaw/djibouti-latest.osm.pbf' using driver `OSM'
#> Simple feature collection with 8610 features and 10 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 41.76667 ymin: 10.41907 xmax: 43.45367 ymax: 12.90639
#> Geodetic CRS:  WGS 84
lines <- st_read("djibouti-latest.osm.pbf", "lines")
#> Reading layer `lines' from data source `/private/var/folders/zp/cc61fbb560g9pqns4g2wtzz40000gn/T/RtmpYmbUJM/reprex-162c639d7c992-smoky-macaw/djibouti-latest.osm.pbf' using driver `OSM'
#> Simple feature collection with 17071 features and 10 fields
#> Geometry type: LINESTRING
#> Dimension:     XY
#> Bounding box:  xmin: 32.48287 ymin: -4.058333 xmax: 55.16667 ymax: 29.94195
#> Geodetic CRS:  WGS 84
polygons <- st_read("djibouti-latest.osm.pbf", "multipolygons")
#> Reading layer `multipolygons' from data source `/private/var/folders/zp/cc61fbb560g9pqns4g2wtzz40000gn/T/RtmpYmbUJM/reprex-162c639d7c992-smoky-macaw/djibouti-latest.osm.pbf' using driver `OSM'
#> Simple feature collection with 145514 features and 25 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 41.67136 ymin: 10.91495 xmax: 43.6579 ymax: 12.79231
#> Geodetic CRS:  WGS 84

# Classify Features
library(osmclass)
points_class <- osm_classify(points, osm_point_polygon_class)
polygons_class <- osm_classify(polygons, osm_point_polygon_class)
lines_class <- osm_classify(lines, osm_line_class)

# See Results
subset(points_class, classified)
#>       classified        main_cat main_tag   main_tag_value alt_cats alt_tags_values
#>    1:       TRUE       transport  highway  traffic_signals     <NA>            <NA>
#>    2:       TRUE       transport  highway  traffic_signals     <NA>            <NA>
#>    3:       TRUE       transport  highway  traffic_signals     <NA>            <NA>
#>    4:       TRUE       transport  highway  traffic_signals     <NA>            <NA>
#>    5:       TRUE       transport  highway  traffic_signals     <NA>            <NA>
#>   ---                                                                              
#> 2850:       TRUE       transport  aeroway holding_position     <NA>            <NA>
#> 2851:       TRUE       transport  aeroway holding_position     <NA>            <NA>
#> 2852:       TRUE       transport  aeroway holding_position     <NA>            <NA>
#> 2853:       TRUE       transport  aeroway holding_position     <NA>            <NA>
#> 2854:       TRUE utilities_other man_made       water_well     <NA>            <NA>
subset(polygons_class, classified)
#>       classified    main_cat main_tag main_tag_value alt_cats   alt_tags_values
#>    1:       TRUE    military  landuse       military     <NA>              <NA>
#>    2:       TRUE residential building     apartments     <NA>              <NA>
#>    3:       TRUE    military  landuse       military     <NA>              <NA>
#>    4:       TRUE      sports  leisure          track   sports sport:"athletics"
#>    5:       TRUE residential  landuse    residential     <NA>              <NA>
#>   ---                                                                          
#> 3416:       TRUE     farming  landuse       farmyard     <NA>              <NA>
#> 3417:       TRUE residential  landuse    residential     <NA>              <NA>
#> 3418:       TRUE residential  landuse    residential     <NA>              <NA>
#> 3419:       TRUE residential  landuse    residential     <NA>              <NA>
#> 3420:       TRUE residential  landuse    residential     <NA>              <NA>
subset(lines_class, classified)
#>       classified main_cat main_tag main_tag_value alt_cats alt_tags_values
#>    1:       TRUE     road  highway      secondary     <NA>            <NA>
#>    2:       TRUE     road  highway      secondary     <NA>            <NA>
#>    3:       TRUE     road  highway       tertiary     <NA>            <NA>
#>    4:       TRUE     road  highway        primary     <NA>            <NA>
#>    5:       TRUE     road  highway      secondary     <NA>            <NA>
#>   ---                                                                     
#> 1922:       TRUE  aeroway  aeroway         runway     <NA>            <NA>
#> 1923:       TRUE  aeroway  aeroway        stopway     <NA>            <NA>
#> 1924:       TRUE  aeroway  aeroway         runway     <NA>            <NA>
#> 1925:       TRUE  aeroway  aeroway         runway     <NA>            <NA>
#> 1926:       TRUE  aeroway  aeroway         runway     <NA>            <NA>

# See what proportion of the data we have classified
sum(points_class$classified)/nrow(points)
#> [1] 0.331475
sum(polygons_class$classified)/nrow(polygons)
#> [1] 0.02350289
sum(lines_class$classified)/nrow(lines)
#> [1] 0.1128229

# Get some additional Info for Lines
library(collapse)
#> collapse 1.9.6.9500, see ?`collapse-package` or ?`collapse-documentation`
#> 
#> Attaching package: 'collapse'
#> The following object is masked from 'package:stats':
#> 
#>     D
lines_info <- lines |> ss(lines_class$classified) |>
  rsplit(lines_class$main_cat[lines_class$classified]) |>
  get_vars(names(osm_line_info_tags), regex = TRUE)

lines_info <- Map(osm_tags_df, lines_info, osm_line_info_tags[names(lines_info)])
str(lines_info)
#> List of 8
#>  $ aeroway :Classes 'data.table' and 'data.frame':   149 obs. of  8 variables:
#>   ..$ ref      : chr [1:149] NA NA NA NA ...
#>   ..$ name     : chr [1:149] NA NA NA NA ...
#>   ..$ man_made : chr [1:149] NA NA NA NA ...
#>   ..$ aerialway: chr [1:149] NA NA NA NA ...
#>   ..$ surface  : chr [1:149] NA NA NA NA ...
#>   ..$ highway  : chr [1:149] NA NA NA NA ...
#>   ..$ length   : chr [1:149] NA NA NA NA ...
#>   ..$ width    : chr [1:149] NA NA NA NA ...
#>   ..- attr(*, ".internal.selfref")=<externalptr> 
#>  $ pipeline:Classes 'data.table' and 'data.frame':   29 obs. of  4 variables:
#>   ..$ name     : chr [1:29] NA NA NA NA ...
#>   ..$ man_made : chr [1:29] "pipeline" "pipeline" "pipeline" "pipeline" ...
#>   ..$ substance: chr [1:29] "hydrocarbons" "hydrocarbons" "hydrocarbons" "water" ...
#>   ..$ location : chr [1:29] "overground" "overground" "overground" NA ...
#>   ..- attr(*, ".internal.selfref")=<externalptr> 
#>  $ power   :Classes 'data.table' and 'data.frame':   66 obs. of  7 variables:
#>   ..$ name       : chr [1:66] NA NA "Adagalla أداغالا" NA ...
#>   ..$ description: chr [1:66] NA NA NA NA ...
#>   ..$ operator   : chr [1:66] NA NA NA NA ...
#>   ..$ man_made   : chr [1:66] NA NA NA NA ...
#>   ..$ power      : chr [1:66] "line" "line" "line" "substation" ...
#>   ..$ location   : chr [1:66] NA NA NA NA ...
#>   ..$ start_date : chr [1:66] NA NA NA NA ...
#>   ..- attr(*, ".internal.selfref")=<externalptr> 
#>  $ railway :Classes 'data.table' and 'data.frame':   234 obs. of  15 variables:
#>   ..$ name       : chr [1:234] "Ethio-Djibouti Railways سكة حديد أديس أبابا - جيبوتي" "سكة حديد أديس أبابا - جيبوتي" "سكة حديد أديس أبابا - جيبوتي" "سكة حديد أديس أبابا - جيبوتي" ...
#>   ..$ operator   : chr [1:234] "شركة السكك الحديدية الجيبوتية الإثيوبية Compagnie du chemin de fer Djibouto-Ethiopien\"" "شركة السكك الحديدية الجيبوتية الإثيوبية Compagnie du chemin de fer Djibouto-Ethiopien\"" "شركة السكك الحديدية الجيبوتية الإثيوبية Compagnie du chemin de fer Djibouto-Ethiopien\"" NA ...
#>   ..$ usage      : chr [1:234] "main" NA NA "main" ...
#>   ..$ service    : chr [1:234] NA "yard" "yard" NA ...
#>   ..$ man_made   : chr [1:234] NA NA NA NA ...
#>   ..$ railway    : chr [1:234] "abandoned" "abandoned" "abandoned" "disused" ...
#>   ..$ tracks     : chr [1:234] NA NA NA NA ...
#>   ..$ electrified: chr [1:234] "no" "no" "no" "no" ...
#>   ..$ embankment : chr [1:234] NA NA NA NA ...
#>   ..$ gauge      : chr [1:234] "1000" "1000" "1000" "1000" ...
#>   ..$ voltage    : chr [1:234] NA NA NA NA ...
#>   ..$ frequency  : chr [1:234] NA NA NA NA ...
#>   ..$ historic   : chr [1:234] NA NA NA NA ...
#>   ..$ width      : chr [1:234] NA NA NA NA ...
#>   ..$ start_date : chr [1:234] "1917" "1917" "1917" "1917" ...
#>   ..- attr(*, ".internal.selfref")=<externalptr> 
#>  $ road    :Classes 'data.table' and 'data.frame':   622 obs. of  13 variables:
#>   ..$ ref        : chr [1:622] NA NA NA NA ...
#>   ..$ name       : chr [1:622] "Avenue Ali Bahdon شارع علي بهدون" "Route de la Siesta طريق القيلولة" NA NA ...
#>   ..$ description: chr [1:622] NA NA NA NA ...
#>   ..$ man_made   : chr [1:622] NA NA NA NA ...
#>   ..$ highway    : chr [1:622] "secondary" "secondary" "tertiary" "primary" ...
#>   ..$ lanes      : chr [1:622] NA NA NA NA ...
#>   ..$ lit        : chr [1:622] NA NA NA NA ...
#>   ..$ maxspeed   : chr [1:622] NA NA NA NA ...
#>   ..$ oneway     : chr [1:622] "yes" "no" NA "yes" ...
#>   ..$ surface    : chr [1:622] NA NA NA NA ...
#>   ..$ smoothness : chr [1:622] NA NA NA NA ...
#>   ..$ tracktype  : chr [1:622] NA NA NA NA ...
#>   ..$ width      : chr [1:622] NA NA NA NA ...
#>   ..- attr(*, ".internal.selfref")=<externalptr> 
#>  $ storage :Classes 'data.table' and 'data.frame':   38 obs. of  3 variables:
#>   ..$ name    : chr [1:38] NA NA NA NA ...
#>   ..$ man_made: chr [1:38] "storage_tank" "storage_tank" "storage_tank" "storage_tank" ...
#>   ..$ content : chr [1:38] NA "fuel" "fuel" "fuel" ...
#>   ..- attr(*, ".internal.selfref")=<externalptr> 
#>  $ telecom :Classes 'data.table' and 'data.frame':   7 obs. of  3 variables:
#>   ..$ name    : chr [1:7] "FLAG Europe-Asia" "FLAG Europe-Asia" "FLAG Europe-Asia" "FLAG Europe-Asia" ...
#>   ..$ man_made: chr [1:7] NA NA NA NA ...
#>   ..$ location: chr [1:7] NA NA NA NA ...
#>   ..- attr(*, ".internal.selfref")=<externalptr> 
#>  $ waterway:Classes 'data.table' and 'data.frame':   779 obs. of  6 variables:
#>   ..$ name        : chr [1:779] "Oued Gôba'ad" "Essalou ويما" "Las Dawwa'o" "Oued D'Ambouli وادي أمبولي" ...
#>   ..$ description : chr [1:779] NA NA NA NA ...
#>   ..$ man_made    : chr [1:779] NA NA NA NA ...
#>   ..$ intermittent: chr [1:779] "yes" "yes" "yes" "yes" ...
#>   ..$ width       : chr [1:779] "11" NA NA NA ...
#>   ..$ tidal       : chr [1:779] NA NA NA NA ...
#>   ..- attr(*, ".internal.selfref")=<externalptr>

# Get 'other_tags' of points layer as list
other_point_tags <- osm_other_tags_list(points$other_tags, values = TRUE)
str(other_point_tags)
#> List of 8610
#>  $ :List of 193
#>   ..$ GNS:dsg_code     : chr "PPLC"
#>   ..$ GNS:dsg_name     : chr "populated place"
#>   ..$ GNS:id           : chr "-2034412"
#>   ..$ GNS:modify_date  : chr "2018-04-11"
#>   ..$ admin_level      : chr "2"
#>   ..$ alt_name:ar      : chr "دجبت;غإبت;جبت;جبوت;جيبوتي;جيبوتى;دجيبوتي;مدينة جيبوتي"
#>   ..$ capital          : chr "yes"
#>   ..$ capital_ISO3166-1: chr "yes"
#>   ..$ is_capital       : chr "country"
#>   ..$ name:ace         : chr "Djibouti"
#>   ..$ name:af          : chr "Djiboeti"
#>   ..$ name:am          : chr "ጅቡቲ"
#>   ..$ name:an          : chr "Chibuti"
#>   ..$ name:ar          : chr "جيبوتي"
#>   ..$ name:arz         : chr "جيبوتي"
#>   ..$ name:ast         : chr "Xibuti"
#>   ..$ name:az          : chr "Cibuti"
#>   ..$ name:azb         : chr "جیبوتی"
#>   ..$ name:ba          : chr "Джибути"
#>   ..$ name:bat-smg     : chr "Džėbotis"
#>   ..$ name:bcl         : chr "Dibouti"
#>   ..$ name:be          : chr "Джыбуці"
#>   ..$ name:bg          : chr "Джибути"
#>   ..$ name:bjn         : chr "Djibouti"
#>   ..$ name:bn          : chr "জিবুতি"
#>   ..$ name:bo          : chr "ཇི་བའོ་ཊི།"
#>   ..$ name:bpy         : chr "ডিজিবোটি"
#>   ..$ name:br          : chr "Djibouti"
#>   ..$ name:bs          : chr "Djibouti"
#>   ..$ name:bxr         : chr "Джибути"
#>   ..$ name:ca          : chr "Djibouti"
#>   ..$ name:ce          : chr "Джибути"
#>   ..$ name:ceb         : chr "Yibuti"
#>   ..$ name:ckb         : chr "جیبووتی"
#>   ..$ name:crh         : chr "Cibuti"
#>   ..$ name:cs          : chr "Džíbutí"
#>   ..$ name:cv          : chr "Джибути"
#>   ..$ name:cy          : chr "Djibouti"
#>   ..$ name:da          : chr "Djibouti"
#>   ..$ name:de          : chr "Dschibuti"
#>   ..$ name:diq         : chr "Cibuti"
#>   ..$ name:dv          : chr "ޖިބުތީ"
#>   ..$ name:ee          : chr "Djibouti"
#>   ..$ name:el          : chr "Τζιμπουτί"
#>   ..$ name:en          : chr "Djibouti"
#>   ..$ name:eo          : chr "Ĝibutio"
#>   ..$ name:es          : chr "Yibuti"
#>   ..$ name:et          : chr "Djibouti"
#>   ..$ name:eu          : chr "Djibuti"
#>   ..$ name:ext         : chr "Yibuti"
#>   ..$ name:fa          : chr "جیبوتی"
#>   ..$ name:fi          : chr "Djibouti"
#>   ..$ name:fr          : chr "Djibouti"
#>   ..$ name:frp         : chr "Dj·iboti"
#>   ..$ name:fy          : chr "Dzjibûty"
#>   ..$ name:ga          : chr "Diobúití"
#>   ..$ name:gag         : chr "Cibuti"
#>   ..$ name:gd          : chr "Djibouti"
#>   ..$ name:gl          : chr "Xibutí"
#>   ..$ name:gv          : chr "Djibouti"
#>   ..$ name:he          : chr "ג'יבוטי"
#>   ..$ name:hi          : chr "जीबूती"
#>   ..$ name:hif         : chr "Djibouti"
#>   ..$ name:hr          : chr "Djibouti"
#>   ..$ name:hsb         : chr "Dźibuti"
#>   ..$ name:ht          : chr "Djibouti"
#>   ..$ name:hu          : chr "Dzsibuti"
#>   ..$ name:hy          : chr "Ջիբութի"
#>   ..$ name:ia          : chr "Djibouti"
#>   ..$ name:id          : chr "Djibouti"
#>   ..$ name:ie          : chr "Djibouti"
#>   ..$ name:ilo         : chr "Djibouti"
#>   ..$ name:io          : chr "Djibuti"
#>   ..$ name:is          : chr "Djíbútí"
#>   ..$ name:it          : chr "Gibuti"
#>   ..$ name:ja          : chr "ジブチ市"
#>   ..$ name:jv          : chr "Djibouti"
#>   ..$ name:ka          : chr "ჯიბუტი"
#>   ..$ name:kab         : chr "Jibuti"
#>   ..$ name:kab-Arab    : chr "جيبوتي"
#>   ..$ name:kg          : chr "Djibuti"
#>   ..$ name:ki          : chr "Djibouti"
#>   ..$ name:kk          : chr "Джибути"
#>   ..$ name:kk-Arab     : chr "دجىيبۋتىي"
#>   ..$ name:kmr         : chr "جیبووتی"
#>   ..$ name:kn          : chr "ಜಿಬೂತೀ"
#>   ..$ name:ko          : chr "지부티"
#>   ..$ name:ks          : chr "جیبوتی"
#>   ..$ name:ku          : chr "Cîbûtî"
#>   ..$ name:ku-Arab     : chr "جیبووتی"
#>   ..$ name:kw          : chr "Sita Jibouti"
#>   ..$ name:ky          : chr "Жибути шаары"
#>   ..$ name:la          : chr "Urbs Dzibutum"
#>   ..$ name:lb          : chr "Dschibuti"
#>   ..$ name:li          : chr "Djibouti"
#>   ..$ name:lij         : chr "Gibuti"
#>   ..$ name:lmo         : chr "Djibouti"
#>   ..$ name:ln          : chr "Djibuti"
#>   ..$ name:lrc         : chr "جیبۊتی"
#>   .. [list output truncated]
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ : NULL
#>  $ : NULL
#>  $ : NULL
#>  $ :List of 1
#>   ..$ noexit: chr "yes"
#>  $ :List of 10
#>   ..$ GNS:dsg_code   : chr "PPL"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "231295"
#>   ..$ GNS:modify_date: chr "2000-11-15"
#>   ..$ alt_name       : chr "Goubetto;Goubatto;Goubétto"
#>   ..$ alt_name:ar    : chr "غوبتّو"
#>   ..$ name:ar        : chr "غوبتو"
#>   ..$ name:en        : chr "Goubetto"
#>   ..$ name:fr        : chr "Goubetto"
#>   ..$ wikidata       : chr "Q5588130\""
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 5
#>   ..$ name:ar: chr "الجزر موشا"
#>   ..$ name:en: chr "Moucha Islands"
#>   ..$ name:fr: chr "Îles Moucha"
#>   ..$ name:hu: chr "Moucha-szigetek"
#>   ..$ sport  : chr "scuba_diving\""
#>  $ :List of 2
#>   ..$ condition: chr "extinct"
#>   ..$ natural  : chr "volcano"
#>  $ :List of 17
#>   ..$ GNS:dsg_code     : chr "PPLA"
#>   ..$ GNS:dsg_name     : chr "populated place"
#>   ..$ GNS:id           : chr "-2032942"
#>   ..$ GNS:modify_date  : chr "2018-04-10"
#>   ..$ alt_name         : chr "`Ali Sabieh;Ali Sabiè;Ali Sabie;Ali Sabiet;‘Ali Sabîẖ;`Ali Sabih;‘Ali Sabieh;‘Ali Sabieh علي صبيح"
#>   ..$ alt_name:ar      : chr "علي سبح"
#>   ..$ alt_name:en      : chr "`Ali Sabih"
#>   ..$ name:ar          : chr "علي صبيح"
#>   ..$ name:cs          : chr "Ali Zabí"
#>   ..$ name:en          : chr "Ali Sabieh"
#>   ..$ name:fr          : chr "Ali Sabieh"
#>   ..$ name:ru          : chr "Али-Сабих"
#>   ..$ name:so          : chr "Cali Sabiix"
#>   ..$ population       : chr "71230"
#>   ..$ source:population: chr "French Wikipedia"
#>   ..$ wikidata         : chr "Q842854"
#>   ..$ wikipedia        : chr "ar:علي صبيح\""
#>  $ :List of 20
#>   ..$ GNS:dsg_code   : chr "PPLA"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2037463"
#>   ..$ GNS:modify_date: chr "2018-04-10"
#>   ..$ alt_name       : chr "Tagiura;Tajura;Tadjura;Tadjoura;Tadjoura تاجورة"
#>   ..$ alt_name:ar    : chr "تاجورة;تدجور;تغإأر;تجر;تدجر"
#>   ..$ is_capital     : chr "county"
#>   ..$ name:aa        : chr "Tagórri"
#>   ..$ name:ar        : chr "تجرة"
#>   ..$ name:de        : chr "Tadschura"
#>   ..$ name:en        : chr "Tadjoura"
#>   ..$ name:es        : chr "Tadyura"
#>   ..$ name:fa        : chr "تاجوره"
#>   ..$ name:fr        : chr "Tadjourah"
#>   ..$ name:ru        : chr "Таджура"
#>   ..$ name:so        : chr "Tajuura"
#>   ..$ name:ur        : chr "تاجورہ"
#>   ..$ population     : chr "25000"
#>   ..$ wikidata       : chr "Q820972"
#>   ..$ wikipedia      : chr "ar:تجرة (جيبوتي)\""
#>  $ :List of 14
#>   ..$ GNS:dsg_code   : chr "PPL"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2037139"
#>   ..$ GNS:modify_date: chr "2000-11-15"
#>   ..$ alt_name       : chr "راندا;Randa"
#>   ..$ alt_name:ar    : chr "راندا;رند"
#>   ..$ is_capital     : chr "district"
#>   ..$ name:aa        : chr "Sūrí Randá"
#>   ..$ name:ar        : chr "رندة"
#>   ..$ name:de        : chr "Randa"
#>   ..$ name:en        : chr "Randa"
#>   ..$ name:fr        : chr "Randa"
#>   ..$ name:ru        : chr "Ранда"
#>   ..$ wikidata       : chr "Q1004708\""
#>  $ :List of 37
#>   ..$ GNS:dsg_code   : chr "PPLA"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2034338"
#>   ..$ GNS:modify_date: chr "2018-04-11"
#>   ..$ alt_name       : chr "Dikil;Dikkil;Dicchil;Dicchil دخيل"
#>   ..$ alt_name:ar    : chr "دكل;دكّل"
#>   ..$ name:ar        : chr "دخيل"
#>   ..$ name:azb       : chr "دخیل"
#>   ..$ name:be        : chr "Дыхіл"
#>   ..$ name:da        : chr "Dikhil"
#>   ..$ name:de        : chr "Dikhil"
#>   ..$ name:el        : chr "Ντικίλ"
#>   ..$ name:en        : chr "Dikhil"
#>   ..$ name:et        : chr "Dikhil"
#>   ..$ name:fa        : chr "دخیل"
#>   ..$ name:fr        : chr "Dikhil"
#>   ..$ name:id        : chr "Dikhil"
#>   ..$ name:it        : chr "Dikhil"
#>   ..$ name:ja        : chr "ディキル"
#>   ..$ name:ka        : chr "დიკილი"
#>   ..$ name:ko        : chr "디킬"
#>   ..$ name:ks        : chr "دخیل"
#>   ..$ name:lt        : chr "Dikilis"
#>   ..$ name:nl        : chr "Dikhil (stad)"
#>   ..$ name:pl        : chr "Dikhil"
#>   ..$ name:ro        : chr "Dikhil"
#>   ..$ name:ru        : chr "Дикиль"
#>   ..$ name:sv        : chr "Dikhil"
#>   ..$ name:tr        : chr "Dikhil"
#>   ..$ name:ur        : chr "دخیل"
#>   ..$ name:zh        : chr "迪基勒"
#>   ..$ name:zu        : chr "Dikhil"
#>   ..$ population     : chr "35000"
#>   ..$ population:date: chr "2012"
#>   ..$ wikidata       : chr "Q620625"
#>   ..$ wikipedia      : chr "ar:دخيل (مدينة)"
#>   ..$ wikipedia:ar   : chr "دخيل (مدينة)\""
#>  $ :List of 17
#>   ..$ GNS:dsg_code   : chr "PPL"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2037694"
#>   ..$ GNS:modify_date: chr "2009-03-18"
#>   ..$ alt_name       : chr "Yoboki"
#>   ..$ alt_name:ar    : chr "يوبوك"
#>   ..$ name:ar        : chr "يوبوكي"
#>   ..$ name:azb       : chr "یوبوکی"
#>   ..$ name:de        : chr "Yoboki"
#>   ..$ name:en        : chr "Yoboki"
#>   ..$ name:fa        : chr "یوبوکی"
#>   ..$ name:fr        : chr "Yoboki"
#>   ..$ name:sv        : chr "Yoboki"
#>   ..$ name:ur        : chr "یوبوکی"
#>   ..$ population     : chr "20644"
#>   ..$ wikidata       : chr "Q2301477"
#>   ..$ wikipedia      : chr "ar:يوبوكي\""
#>  $ :List of 1
#>   ..$ natural: chr "volcano"
#>  $ :List of 15
#>   ..$ GNS:dsg_code: chr "PPL"
#>   ..$ GNS:id      : chr "-2034456"
#>   ..$ alt_name:ar : chr "دورّ"
#>   ..$ name:ar     : chr "درة"
#>   ..$ name:azb    : chr "دره"
#>   ..$ name:de     : chr "Dorra"
#>   ..$ name:fa     : chr "دره"
#>   ..$ name:fr     : chr "Dorra"
#>   ..$ name:kk     : chr "Дорра"
#>   ..$ name:ru     : chr "Дорра"
#>   ..$ name:sv     : chr "Dorra"
#>   ..$ name:ur     : chr "درہ"
#>   ..$ type        : chr "boundary"
#>   ..$ wikidata    : chr "Q970073"
#>   ..$ wikipedia   : chr "fr:Dorra\""
#>  $ :List of 1
#>   ..$ natural: chr "volcano"
#>  $ :List of 1
#>   ..$ natural: chr "volcano"
#>  $ :List of 1
#>   ..$ natural: chr "volcano"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 6
#>   ..$ GNS:dsg_code: chr "PPL"
#>   ..$ GNS:id      : chr "-2033567"
#>   ..$ name:ar     : chr "بالهو"
#>   ..$ name:fr     : chr "Balho"
#>   ..$ wikidata    : chr "Q804945"
#>   ..$ wikipedia   : chr "fr:Balho\""
#>  $ :List of 13
#>   ..$ GNS:dsg_code   : chr "PPLA"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2036711"
#>   ..$ GNS:modify_date: chr "2018-04-11"
#>   ..$ alt_name       : chr "Obok;Ubuk;Hayyou;Obok أوبوك"
#>   ..$ alt_name:ar    : chr "أوبوك;أبخ;وبوك;هيّو"
#>   ..$ alt_name:en    : chr "أوبوك"
#>   ..$ name:ar        : chr "أبخ"
#>   ..$ name:en        : chr "Obock"
#>   ..$ name:fr        : chr "Obock"
#>   ..$ population     : chr "8500"
#>   ..$ wikidata       : chr "Q860179"
#>   ..$ wikipedia      : chr "ar:أوبوك\""
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 2
#>   ..$ surface        : chr "asphalt"
#>   ..$ traffic_calming: chr "hump"
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ noexit: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ : NULL
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ traffic_signals: chr "signal"
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 4
#>   ..$ landuse : chr "military"
#>   ..$ military: chr "naval_base"
#>   ..$ name:ar : chr "توقف البحرية العسكرية"
#>   ..$ name:fr : chr "Escale Marine Militaire\""
#>  $ :List of 4
#>   ..$ name:ar : chr "شابلي"
#>   ..$ name:en : chr "Shabili"
#>   ..$ name:fr : chr "Chebele"
#>   ..$ wikidata: chr "Q5066004\""
#>  $ :List of 4
#>   ..$ addr:city: chr "جيبوتي"
#>   ..$ name:ar  : chr "الجميل"
#>   ..$ name:fr  : chr "AL GAMIL"
#>   ..$ shop     : chr "convenience\""
#>  $ :List of 3
#>   ..$ name:ar   : chr "صاروخ"
#>   ..$ name:fr   : chr "Fusée"
#>   ..$ tower:type: chr "observation\""
#>  $ :List of 3
#>   ..$ name:ar: chr "أربور"
#>   ..$ name:en: chr "Orobor"
#>   ..$ name:fr: chr "Orobor\""
#>  $ :List of 4
#>   ..$ alt_name:ar: chr "أوبوك"
#>   ..$ leisure    : chr "marina"
#>   ..$ name:ar    : chr "أبخ"
#>   ..$ name:fr    : chr "Obock\""
#>  $ :List of 9
#>   ..$ alt_name    : chr "علي أدي;مخيم علي أدي"
#>   ..$ alt_name:ar : chr "علي أدي;مخيم علي أدي"
#>   ..$ long_name   : chr "مخيم علي عدي"
#>   ..$ long_name:ar: chr "مخيم علي عدي"
#>   ..$ long_name:en: chr "Ali-Addeh Refugee Camp"
#>   ..$ name:ar     : chr "علي عدي"
#>   ..$ name:en     : chr "Ali Adde"
#>   ..$ name:fr     : chr "Ali Addé"
#>   ..$ wikidata    : chr "Q1753852\""
#>  $ :List of 3
#>   ..$ name:ar : chr "دعسبيو"
#>   ..$ name:fr : chr "Daasbiyo"
#>   ..$ wikidata: chr "Q15213041\""
#>  $ :List of 1
#>   ..$ ford: chr "yes"
#>  $ :List of 10
#>   ..$ GNS:dsg_code   : chr "PPL"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2035639"
#>   ..$ GNS:modify_date: chr "2000-11-15"
#>   ..$ alt_name       : chr "Hol Holl;Holl-Holl;Holhol"
#>   ..$ alt_name:ar    : chr "هول هولّ;هولهول"
#>   ..$ alt_name:en    : chr "Holhol"
#>   ..$ name:ar        : chr "هلهول"
#>   ..$ name:en        : chr "Holl-Holl"
#>   ..$ name:fr        : chr "Holl-Holl\""
#>  $ :List of 15
#>   ..$ GNS:dsg_code   : chr "PPLA"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2033189"
#>   ..$ GNS:modify_date: chr "2018-04-10"
#>   ..$ alt_name       : chr "أرتا;ارتا;`Arta;‘Arta;‘Arta أرتا"
#>   ..$ alt_name:ar    : chr "أرتا;ارتا;عرتا;عرت"
#>   ..$ name:ar        : chr "عرتا"
#>   ..$ name:de        : chr "Arta"
#>   ..$ name:en        : chr "Arta"
#>   ..$ name:fa        : chr "عرتا"
#>   ..$ name:fr        : chr "Arta"
#>   ..$ name:ur        : chr "عرتا"
#>   ..$ population     : chr "10275"
#>   ..$ wikidata       : chr "Q705884"
#>   ..$ wikipedia      : chr "ar:أرتا\""
#>  $ :List of 2
#>   ..$ name:ar: chr "شاطئ عرتا"
#>   ..$ name:fr: chr "ARTA PLAGE\""
#>  $ : NULL
#>  $ :List of 1
#>   ..$ name:ar: chr "TC١٢\""
#>  $ :List of 1
#>   ..$ name:ar: chr "MS١٢\""
#>  $ :List of 3
#>   ..$ landuse: chr "military"
#>   ..$ name:ar: chr "نقطة المراقب كرون"
#>   ..$ name:en: chr "Koron OBS point\""
#>  $ : NULL
#>  $ : NULL
#>  $ : NULL
#>  $ :List of 5
#>   ..$ abandoned:aeroway: chr "aerodrome"
#>   ..$ icao             : chr "HDHE"
#>   ..$ name:ar          : chr "مطار هيركال"
#>   ..$ name:fr          : chr "Aérodrome d'Hercale"
#>   ..$ wikidata         : chr "Q5739242\""
#>  $ :List of 7
#>   ..$ aeroway : chr "aerodrome"
#>   ..$ iata    : chr "MHI"
#>   ..$ icao    : chr "HDMO"
#>   ..$ name:ar : chr "مطار موشا"
#>   ..$ name:en : chr "Moucha Airport"
#>   ..$ name:fr : chr "Aérodrome de Moucha"
#>   ..$ wikidata: chr "Q11824610\""
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ : NULL
#>  $ : NULL
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ : NULL
#>  $ :List of 1
#>   ..$ railway: chr "level_crossing"
#>  $ :List of 4
#>   ..$ bicycle      : chr "no"
#>   ..$ foot         : chr "no"
#>   ..$ horse        : chr "no"
#>   ..$ motor_vehicle: chr "yes"
#>  $ : NULL
#>  $ :List of 2
#>   ..$ amenity   : chr "fuel"
#>   ..$ wheelchair: chr "no"
#>  $ :List of 4
#>   ..$ long_name:ar: chr "قرية مولود"
#>   ..$ name:ar     : chr "مولود"
#>   ..$ name:en     : chr "Moulud Village"
#>   ..$ name:fr     : chr "Mouloud\""
#>  $ :List of 4
#>   ..$ addr:city: chr "جيبوتي"
#>   ..$ name:ar  : chr "نزل الرمال"
#>   ..$ name:fr  : chr "Auberge Sable"
#>   ..$ tourism  : chr "motel\""
#>  $ :List of 4
#>   ..$ addr:city: chr "جيبوتي"
#>   ..$ name:ar  : chr "فندق علي صبية"
#>   ..$ name:fr  : chr "Hôtel Ali Sabieh"
#>   ..$ tourism  : chr "motel\""
#>  $ :List of 6
#>   ..$ alt_name   : chr "غورابو"
#>   ..$ alt_name:ar: chr "غورابو"
#>   ..$ name:ar    : chr "غور آبوس"
#>   ..$ name:en    : chr "Gour A'Bbous"
#>   ..$ name:fr    : chr "Gour A'Bbous"
#>   ..$ wikidata   : chr "Q5584359\""
#>  $ :List of 3
#>   ..$ amenity: chr "car_rental"
#>   ..$ name:ar: chr "مكتب وروكار"
#>   ..$ name:fr: chr "Europcar Office\""
#>  $ :List of 4
#>   ..$ name:ar: chr "مكتب الهجرة"
#>   ..$ name:en: chr "Immigration Office"
#>   ..$ name:fr: chr "Bureau d'immigration"
#>   ..$ office : chr "government\""
#>  $ :List of 10
#>   ..$ GNS:dsg_code   : chr "PPL"
#>   ..$ GNS:dsg_name   : chr "populated place"
#>   ..$ GNS:id         : chr "-2037641"
#>   ..$ GNS:modify_date: chr "2009-03-18"
#>   ..$ alt_name       : chr "Gué'a;Oue`a;Wê‘a;We`a;Ouê‘a"
#>   ..$ alt_name:en    : chr "Oue`a"
#>   ..$ name:ar        : chr "وع"
#>   ..$ name:en        : chr "Ouea"
#>   ..$ name:fr        : chr "Ouéah"
#>   ..$ population     : chr "5000\""
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>  $ :List of 1
#>   ..$ is_in:continent: chr "Africa"
#>   [list output truncated]
```

<sup>Created on 2023-08-11 with [reprex v2.0.2](https://reprex.tidyverse.org)</sup>
