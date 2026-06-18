# Classify OSM Features

Classifies OSM features into meaningful functional or analytical
categories, according to a supplied classification.

## Usage

``` r
osm_classify(data, classification)
```

## Arguments

- data:

  imported layer from an OSM PBF file. Usually an 'sf' data frame, but
  the geometry column is unnecessary. Importantly, the data frame should
  have an 'other_tags' column with OSM PBF formatting.

- classification:

  a 2-level nested list providing a classification. The layers of the
  list are:

  |  |  |  |
  |----|----|----|
  | *categories* |  | a list of tags and matched values that constitute a feature category. |
  |  |  | *tags* |
  |  | a character vector of tag values to match, or `""` to match all possible values. It is also possible to match all except certain tags by negating them with `"!"` e.g. `"!no"`. Obviously, it is not sensible to mix negation with other specifications. |  |

  See
  [`osm_point_polygon_class`](https://sebkrantz.github.io/osmclass/reference/classifications.md)
  and
  [`osm_line_class`](https://sebkrantz.github.io/osmclass/reference/classifications.md)
  for example classifications.

## Value

a *data.table* with rows matching the input frame and columns

- classified:

  logical. Whether the feature was classified i.e. matched by any
  tag-value in the `classification`.

- main_cat:

  character. The first category the feature was assigned to, depending
  on the order of categories in the `classification`.

- main_tag:

  character. The tag matched for the main category.

- main_tag_value:

  character. The value matched on.

- alt_cats:

  character. Alternative (secondary) categories assigned,
  comma-separated if multiple.

- alt_tags_values:

  character. The tags and double-quoted values matched for secondary
  categories, comma-separated if multiple.

## Note

It is not necessary to expand the 'other_tags' column, e.g. using
[`osm_tags_df()`](https://sebkrantz.github.io/osmclass/reference/osm_tags_df.md).
`osm_classify()` efficiently searches the content of that column without
expanding it.

## See also

[osmclass-package](https://sebkrantz.github.io/osmclass/reference/osmclass-package.md)

## Examples

``` r
# See Examples at ?osmclass for a full examples

# Classify OSM Points in Djibouti
djibouti_points_class <- osm_classify(djibouti_points, osm_point_polygon_class)
head(djibouti_points_class)
#>    classified  main_cat main_tag  main_tag_value alt_cats alt_tags_values
#>        <lgcl>    <char>   <char>          <char>   <char>          <char>
#> 1:      FALSE      <NA>     <NA>            <NA>     <NA>            <NA>
#> 2:       TRUE transport  highway traffic_signals     <NA>            <NA>
#> 3:       TRUE transport  highway traffic_signals     <NA>            <NA>
#> 4:       TRUE transport  highway traffic_signals     <NA>            <NA>
#> 5:       TRUE transport  highway traffic_signals     <NA>            <NA>
#> 6:      FALSE      <NA>     <NA>            <NA>     <NA>            <NA>
collapse::descr(djibouti_points_class)
#> Dataset: djibouti_points_class, 6 Variables, N = 8608
#> --------------------------------------------------------------------------------
#> classified (logical): 
#> Statistics
#>      N  Ndist
#>   8608      2
#> Table
#>        Freq   Perc
#> FALSE  5755  66.86
#> TRUE   2853  33.14
#> --------------------------------------------------------------------------------
#> main_cat (character): 
#> Statistics (66.86% NAs)
#>      N  Ndist
#>   2853     28
#> Table
#>                  Freq   Perc
#> power             997  34.95
#> utilities_other   921  32.28
#> transport         211   7.40
#> shopping          182   6.38
#> food               96   3.36
#> communications     75   2.63
#> facilities         51   1.79
#> accommodation      36   1.26
#> tourism            36   1.26
#> financial          32   1.12
#> institutional      31   1.09
#> health             30   1.05
#> religion           26   0.91
#> public_service     21   0.74
#> ... 14 Others     108   3.79
#> 
#> Summary of Table Frequencies
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>       1       6      20     102      40     997 
#> --------------------------------------------------------------------------------
#> main_tag (character): 
#> Statistics (66.86% NAs)
#>      N  Ndist
#>   2853     22
#> Table
#>               Freq   Perc
#> power          997  34.95
#> man_made       961  33.68
#> amenity        340  11.92
#> shop           185   6.48
#> highway         76   2.66
#> office          72   2.52
#> railway         64   2.24
#> tourism         63   2.21
#> aeroway         39   1.37
#> tower:type      17   0.60
#> leisure         14   0.49
#> historic         9   0.32
#> waterway         3   0.11
#> craft            3   0.11
#> ... 8 Others    10   0.35
#> 
#> Summary of Table Frequencies
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>     1.0     1.2    11.5   129.7    70.0   997.0 
#> --------------------------------------------------------------------------------
#> main_tag_value (character): 
#> Statistics (66.86% NAs)
#>      N  Ndist
#>   2853    179
#> Table
#>                   Freq   Perc
#> water_well         918  32.18
#> tower              787  27.58
#> pole               174   6.10
#> restaurant          62   2.17
#> traffic_signals     54   1.89
#> level_crossing      45   1.58
#> water_point         35   1.23
#> crossing            29   1.02
#> hotel               26   0.91
#> antenna             25   0.88
#> place_of_worship    24   0.84
#> cafe                21   0.74
#> bank                18   0.63
#> waste_disposal      18   0.63
#> ... 165 Others     617  21.63
#> 
#> Summary of Table Frequencies
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>       1       1       2      16       6     918 
#> --------------------------------------------------------------------------------
#> alt_cats (character): 
#> Statistics (97.8% NAs)
#>     N  Ndist
#>   189     15
#> Table
#>                               Freq   Perc
#> office_other                    55  29.10
#> tourism                         35  18.52
#> health                          25  13.23
#> religion                        22  11.64
#> communications                  21  11.11
#> shopping                        11   5.82
#> transport                        9   4.76
#> power                            2   1.06
#> religion, religion               2   1.06
#> utilities_other                  2   1.06
#> military                         1   0.53
#> sports                           1   0.53
#> religion, religion, religion     1   0.53
#> storage                          1   0.53
#> ... 1 Others                     1   0.53
#> 
#> Summary of Table Frequencies
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>       1       1       2      13      22      55 
#> --------------------------------------------------------------------------------
#> alt_tags_values (character): 
#> Statistics (97.8% NAs)
#>     N  Ndist
#>   189     36
#> Table
#>                                   Freq   Perc
#> tourism:"hotel"                     26  13.76
#> tower:type:"communication"          21  11.11
#> religion:"muslim"                   20  10.58
#> office:"government"                 16   8.47
#> healthcare:"pharmacy"               13   6.88
#> office:"telecommunication"          12   6.35
#> shop:"travel_agency"                 9   4.76
#> office:"diplomatic"                  9   4.76
#> public_transport:"station"           7   3.70
#> healthcare:"clinic"                  5   2.65
#> office:"insurance"                   5   2.65
#> healthcare:"hospital"                4   2.12
#> office:"educational_institution"     4   2.12
#> tourism:"apartment"                  4   2.12
#> ... 22 Others                       34  17.99
#> 
#> Summary of Table Frequencies
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>     1.0     1.0     2.0     5.2     5.5    26.0 
#> --------------------------------------------------------------------------------
```
