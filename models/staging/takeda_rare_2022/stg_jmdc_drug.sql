WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_drug') }}
  ),

  renamed AS (
    SELECT
      "加入者id" AS "加入者id",
      "レセid" AS "レセid",
      "明細id" AS "明細id",
      "レセ種別" AS "レセ種別",
      "診療年月" AS "診療年月",
      "医療施設id" AS "医療施設id",
      "医薬品コード" AS "医薬品コード",
      "医薬品名" AS "医薬品名",
      "薬価" AS "薬価",
      "処方日" AS "処方日",
      "調剤日" AS "調剤日",
      "1処方あたりの1日投与量" AS "1処方あたりの1日投与量",
      "投与量単位" AS "投与量単位",
      "1処方あたりの投与日数" AS "1処方あたりの投与日数",
      "投薬量" AS "投薬量",
      "同時id" AS "同時id",
      "頓服フラグ" AS "頓服フラグ",
      "診療区分" AS "診療区分",
      "処方金額" AS "処方金額",
      "調剤料" AS "調剤料",
      "薬剤料" AS "薬剤料",
      "加算料" AS "加算料",
      "レセプト記載点数" AS "レセプト記載点数",
      "総点数" AS "総点数"
    FROM source
  )

SELECT
  *
FROM renamed
