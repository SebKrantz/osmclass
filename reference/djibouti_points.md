# OSM Points Layer for Djibouti, August 2023

A data table of all 8608 OSM points in Djibouti as of August 2023.

## Usage

``` r
djibouti_points
```

## Format

A data table with 8608 rows and 10 columns. The first column contains
the OSM id of each point. Other columns give the values of frequent OSM
tags for point features. The last column is called 'other_tags' and
contains all remaining (less frequent) tags. Please consult the [OSM
Feature Documentation](https://wiki.openstreetmap.org/wiki/Map_features)
for the exact meaning and frequently used values of these tags.

## Source

Geofabrik download server (https://download.geofabrik.de/). See
[osmclass-package](https://sebkrantz.github.io/osmclass/reference/osmclass-package.md)
for how to download it.

## See also

[osmclass-package](https://sebkrantz.github.io/osmclass/reference/osmclass-package.md)

## Examples

``` r
data(djibouti_points)
```
