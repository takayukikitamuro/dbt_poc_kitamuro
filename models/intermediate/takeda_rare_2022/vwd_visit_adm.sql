WITH
  import_receipt AS (
    SELECT
      *
    FROM {{ ref('stg_jmdc_receipt') }}
  ),

  final_cte AS (
    SELECT
      "加入者id" AS "加入者id",
      "診療年月" AS "診療年月",
      SUM((CASE "レセ種別" WHEN '入院' THEN CAST("診療実日数" AS BIGINT) ELSE 0 END)) AS adm,
      SUM((CASE "レセ種別" WHEN '入院' THEN CAST("診療実日数" AS BIGINT) ELSE 0 END)) AS visit
    FROM
      import_receipt
    WHERE
      "レセ種別" IN ('入院', '入院外')
    GROUP BY
      "加入者id",
      "診療年月"
  )

SELECT
  *
FROM final_cte
