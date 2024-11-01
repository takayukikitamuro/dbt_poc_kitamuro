WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_facility') }}
  ),

  renamed AS (
    SELECT
      "医療施設id" AS "医療施設id",
      "ベッド数" AS "ベッド数",
      "hpgp区分" AS "hpgp区分",
      "診療科大分類" AS "診療科大分類",
      "診療科中分類" AS "診療科中分類",
      "経営体" AS "経営体",
      "在宅療養支援診療所" AS "在宅療養支援診療所",
      "がん診療連携拠点病院" AS "がん診療連携拠点病院",
      "dpc導入医療機関" AS "dpc導入医療機関",
      "特定機能病院" AS "特定機能病院"
    FROM source
  )

SELECT
  *
FROM renamed
