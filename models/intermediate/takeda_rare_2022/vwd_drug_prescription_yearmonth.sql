WITH
  import_drug AS (
    SELECT
      *
    FROM {{ ref('stg_jmdc_drug') }}
  ),

  final_cte AS (
    SELECT DISTINCT
      "加入者id" AS "加入者id",
      "診療年月" AS "診療年月"
    FROM
      import_drug
    WHERE
      "医薬品コード" IN (100000062588, 100000083608, 100000087746)
  )

SELECT
  *
FROM final_cte
