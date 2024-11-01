WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_receipt') }}
  ),

  renamed AS (
    SELECT
      "加入者id" AS "加入者id",
      "レセid" AS "レセid",
      "レセ種別" AS "レセ種別",
      "診療年月" AS "診療年月",
      "紙レセフラグ" AS "紙レセフラグ",
      "医療施設id" AS "医療施設id",
      "診療科大分類" AS "診療科大分類",
      "診療科中分類" AS "診療科中分類",
      "レセプト診療科" AS "レセプト診療科",
      "診療実日数" AS "診療実日数",
      "入院日" AS "入院日",
      "退院日" AS "退院日",
      "総点数" AS "総点数"
    FROM source
  )

SELECT
  *
FROM renamed
