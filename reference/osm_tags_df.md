# Extract Tags as Columns from an OSM PBF Layer

Extract Tags as Columns from an OSM PBF Layer

## Usage

``` r
osm_tags_df(data, tags, na.prop = 0)
```

## Arguments

- data:

  an imported layer from an OSM PBF file. Usually has a few important
  tags already expanded as columns, and an 'other_tags' column which
  compounds less frequent tags as character strings.

- tags:

  character. A vector of tags to extract as columns.

- na.prop:

  double. Proportion of features having a tag in order to keep the
  column.

## Value

a *data.table* with the supplied `tags` as columns, and the same number
of rows as the input frame.

## See also

[osmclass-package](https://sebkrantz.github.io/osmclass/reference/osmclass-package.md)

## Examples

``` r
# See Examples at ?osmclass for full examples

# Extracting tags of interest (some of which are inside 'other_tags')
tags <- c("osm_id", "highway", "man_made", "name", "alt_name",
          "description", "wikidata", "amenity", "tourism")
head(osm_tags_df(djibouti_points, tags))
#>       osm_id         highway man_made            name alt_name description
#>       <char>          <char>   <char>          <char>   <char>      <char>
#> 1:  27565085            <NA>     <NA> Djibouti جيبوتي     <NA>        <NA>
#> 2: 260937317 traffic_signals     <NA>            <NA>     <NA>        <NA>
#> 3: 265054255 traffic_signals     <NA>            <NA>     <NA>        <NA>
#> 4: 265065760 traffic_signals     <NA>            <NA>     <NA>        <NA>
#> 5: 265071403 traffic_signals     <NA>            <NA>     <NA>        <NA>
#> 6: 266529985            <NA>     <NA>            <NA>     <NA>        <NA>
#>    wikidata amenity tourism
#>      <char>  <char>  <char>
#> 1:    Q3604    <NA>    <NA>
#> 2:     <NA>    <NA>    <NA>
#> 3:     <NA>    <NA>    <NA>
#> 4:     <NA>    <NA>    <NA>
#> 5:     <NA>    <NA>    <NA>
#> 6:     <NA>    <NA>    <NA>

# Only keeping tags with at least 5\% non-missing
head(osm_tags_df(djibouti_points, tags, na.prop = 0.05))
#>       osm_id man_made            name alt_name wikidata
#>       <char>   <char>          <char>   <char>   <char>
#> 1:  27565085     <NA> Djibouti جيبوتي     <NA>    Q3604
#> 2: 260937317     <NA>            <NA>     <NA>     <NA>
#> 3: 265054255     <NA>            <NA>     <NA>     <NA>
#> 4: 265065760     <NA>            <NA>     <NA>     <NA>
#> 5: 265071403     <NA>            <NA>     <NA>     <NA>
#> 6: 266529985     <NA>            <NA>     <NA>     <NA>
```
