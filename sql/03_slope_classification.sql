DROP TABLE IF EXISTS slope_class;
DROP TABLE IF EXISTS slope_mosaic;

CREATE TABLE slope_class AS
SELECT
    row_number() OVER ()::integer AS rid,

    ST_Reclass(
        ST_Resample(
            s.rast,
            ref.rast,
            'NearestNeighbor'
        ),
        1,
        '[0-2]:3,(2-5]:2,(5-10]:1,(10-9999]:0',
        '8BUI',
        255
    ) AS rast

FROM slope_analiz AS s
CROSS JOIN ndwi_reference AS ref;

ALTER TABLE slope_class
    ADD PRIMARY KEY (rid);

CREATE INDEX slope_class_rast_gist
ON slope_class
USING GIST (ST_ConvexHull(rast));

CREATE TABLE slope_mosaic AS
SELECT
    ST_Union(rast) AS rast
FROM slope_class;

ANALYZE slope_class;
ANALYZE slope_mosaic;