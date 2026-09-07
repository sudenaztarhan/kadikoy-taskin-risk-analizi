DROP TABLE IF EXISTS dem_class;
DROP TABLE IF EXISTS dem_mosaic;

CREATE TABLE dem_class AS
SELECT
    row_number() OVER ()::integer AS rid,

    ST_Reclass(
        ST_Resample(
            d.rast,
            ref.rast,
            'Bilinear'
        ),
        1,
        '[-9999-5]:2,(5-15]:1,(15-9999]:0',
        '8BUI',
        255
    ) AS rast

FROM dem_kes AS d
CROSS JOIN ndwi_reference AS ref;

ALTER TABLE dem_class
    ADD PRIMARY KEY (rid);

CREATE INDEX dem_class_rast_gist
ON dem_class
USING GIST (ST_ConvexHull(rast));


CREATE TABLE dem_mosaic AS
SELECT
    ST_Union(rast) AS rast
FROM dem_class;

ANALYZE dem_class;
ANALYZE dem_mosaic;