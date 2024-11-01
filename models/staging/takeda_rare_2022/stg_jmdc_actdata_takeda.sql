WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_actdata') }}
  ),

  renamed AS (
    SELECT
      "加入者id" AS "加入者id",
      "レセid" AS "レセid",
      "明細id" AS "明細id",
      "レセ種別" AS "レセ種別",
      "診療年月" AS "診療年月",
      "実施年月日" AS "実施年月日",
      "医療施設id" AS "医療施設id",
      "標準化診療行為コード" AS "標準化診療行為コード",
      "標準化診療行為バージョン" AS "標準化診療行為バージョン",
      "標準化診療行為名" AS "標準化診療行為名",
      "回数" AS "回数",
      "同時id" AS "同時id",
      "診療区分" AS "診療区分",
      "1回あたり点数" AS "1回あたり点数",
      "1回あたり加算割合" AS "1回あたり加算割合",
      "1回あたり金額" AS "1回あたり金額",
      "レセプト記載点数" AS "レセプト記載点数"
    FROM source
  )

SELECT
  *
FROM renamed
