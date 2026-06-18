# Changelog

## osmclass 0.1.5

CRAN release: 2026-05-19

- Added
  [`osm_other_tags_str()`](https://sebkrantz.github.io/osmclass/reference/osm_other_tags_str.md):
  reformats the ‘other_tags’ hstore column as a comma-separated
  `key:"value"` string per feature, with an `exclude` argument to drop
  tag keys already captured by
  [`osm_classify()`](https://sebkrantz.github.io/osmclass/reference/osm_classify.md)
  (e.g. those in `main_tag`/`alt_tags_values`). Useful for preserving
  the remaining OSM tags without duplicating classification output.

## osmclass 0.1.4

CRAN release: 2026-05-02

- Added `osm_point_polygon_class_det`: A new detailed classification of
  point and polygon features by economic significance.

- Added `osm_point_polygon_class_det_agg`: A mapping of the detailed
  categories to more aggregate ones.

## osmclass 0.1.3

CRAN release: 2023-08-17

- Adding `djibouti_points` data to be able to execute examples and
  appease the CRAN team.

## osmclass 0.1.2

- Further minor things demanded by CRAN team.

## osmclass 0.1.1

- Fix URL as demanded by CRAN team.

## osmclass 0.1.0

- First CRAN submission.
