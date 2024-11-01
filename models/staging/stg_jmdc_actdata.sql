WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_actdata') }}
  ),

  renamed AS (
    SELECT
        "加入者id" AS patient_id,
        "レセid" AS receipt_id,
        "明細id" AS detail_id,
        "レセ種別" AS receipt_type,
        "診療年月" AS medical_year_month,
        "実施年月日" AS implementation_date,
        "医療施設id" AS facility_id,
        "標準化診療行為コード" AS procedure_code,
        "標準化診療行為バージョン" AS procedure_version,
        "標準化診療行為名" AS procedure_name,
        "回数" AS procedure_count,
        "同時id" AS simultaneous_id,
        "診療区分" AS medical_classification,
        "1回あたり点数" AS points_per_visit,
        "1回あたり加算割合" AS percentage_per_visit,
        "1回あたり金額" AS amount_per_visit,
        "レセプト記載点数" AS recorded_points
    FROM source
  )

SELECT
  *
FROM renamed
