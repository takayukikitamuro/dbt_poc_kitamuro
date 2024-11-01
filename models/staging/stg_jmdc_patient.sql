WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_patient') }}
  ),

  renamed AS (
    SELECT
        "加入者id" AS patient_id,
        "加入者生年月" AS patient_birthdate,
        "加入者性別" AS patient_gender,
        "家族id" AS family_id,
        "本人家族コード" AS self_family_code,
        "本人家族" AS self_family,
        "続柄コード" AS relationship_code,
        "続柄" AS relationship,
        "観察開始年月" AS observation_start_month,
        "観察終了年月" AS observation_end_month,
        "観察終了理由(死亡)フラグ" AS observation_end_reason_death_flag
    FROM source
  )

SELECT
  *
FROM renamed
