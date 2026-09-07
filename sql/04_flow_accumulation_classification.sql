DROP TABLE IF EXISTS flow_class;
DROP TABLE IF EXISTS flow_mosaic;

CREATE TABLE flow_class AS
SELECT
    row_number() OVER ()::integer AS rid,

    ST_Reclass(
        ST_Resample(
            f.rast,
            ref.rast,
            'NearestNeighbor'
        ),
        1,
        '[-999999-50]:0,(50-999999]:1',
        '8BUI',
        255
    ) AS rast

FROM flow_accumulation AS f
CROSS JOIN ndwi_reference AS ref;

ALTER TABLE flow_class
    ADD PRIMARY KEY (rid);

CREATE INDEX flow_class_rast_gist
ON flow_class
USING GIST (ST_ConvexHull(rast));

CREATE TABLE flow_mosaic AS
SELECT
    ST_Union(rast) AS rast
FROM flow_class;

ANALYZE flow_class;
ANALYZE flow_mosaic;