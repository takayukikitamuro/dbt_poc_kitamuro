WITH
  import_disease AS (
    SELECT
      *
    FROM {{ ref('stg_jmdc_disease') }}
  ),

  final_cte AS (
    SELECT DISTINCT
      "加入者id" AS "加入者id",
      "診療年月" AS "診療年月"
    FROM
      import_disease
    WHERE
      "標準傷病コード" = '2864002' AND "疑いフラグ" IS NULL
  )

SELECT
  *
FROM final_cte
