DROP TABLE IF EXISTS risk_ndwi_dem;
DROP TABLE IF EXISTS risk_ndwi_dem_slope;
DROP TABLE IF EXISTS risk_final;

CREATE TABLE risk_ndwi_dem AS
SELECT

    ST_MapAlgebra(
        n.rast,
        d.rast,
        '[rast1] + [rast2]',
        '32BUI',
        'INTERSECTION',
        '0',
        '0',
        0
    ) AS rast

FROM ndwi_mosaic AS n
CROSS JOIN dem_mosaic AS d;

CREATE TABLE risk_ndwi_dem_slope AS
SELECT

    ST_MapAlgebra(
        a.rast,
        s.rast,
        '[rast1] + [rast2]',
        '32BUI',
        'INTERSECTION',
        '0',
        '0',
        0
    ) AS rast

FROM risk_ndwi_dem AS a
CROSS JOIN slope_mosaic AS s;

CREATE TABLE risk_final AS
SELECT

    1 AS rid,

    ST_MapAlgebra(
        a.rast,
        f.rast,
        '[rast1] + [rast2]',
        '32BUI',
        'INTERSECTION',
        '0',
        '0',
        0
    ) AS rast

FROM risk_ndwi_dem_slope AS a
CROSS JOIN flow_mosaic AS f;

ALTER TABLE risk_final
    ADD PRIMARY KEY (rid);

CREATE INDEX risk_final_rast_gist
ON risk_final
USING GIST (ST_ConvexHull(rast));

ANALYZE risk_final;