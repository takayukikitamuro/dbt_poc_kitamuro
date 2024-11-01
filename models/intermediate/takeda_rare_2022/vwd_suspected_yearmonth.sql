WITH
  import_receipt AS (
    SELECT
      *
    FROM {{ ref('stg_jmdc_disease') }}
  ),

  final_cte AS (
    SELECT DISTINCT
      "加入者id" AS "加入者id",
      "診療年月" AS "診療年月"
    FROM
      import_receipt
    WHERE
      "標準傷病コード" = '2864002'
  )

SELECT
  *
FROM final_cte
