DROP TABLE IF EXISTS ndwi_class;
DROP TABLE IF EXISTS ndwi_mosaic;
DROP TABLE IF EXISTS ndwi_reference;

CREATE TABLE ndwi_class AS
SELECT
    rid,

    ST_Reclass(
        rast,
        1,
        '[-1-0]:0,(0-1]:1',
        '8BUI',
        255
    ) AS rast

FROM kadikoy_ndwi_raster;

ALTER TABLE ndwi_class
    ADD PRIMARY KEY (rid);

CREATE INDEX ndwi_class_rast_gist
ON ndwi_class
USING GIST (ST_ConvexHull(rast));

CREATE TABLE ndwi_mosaic AS
SELECT
    ST_Union(rast) AS rast
FROM ndwi_class;

CREATE TABLE ndwi_reference AS
SELECT
    ST_Union(rast) AS rast
FROM kadikoy_ndwi_raster;

ANALYZE ndwi_class;
ANALYZE ndwi_mosaic;
ANALYZE ndwi_reference;