WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_patient') }}
  ),

  renamed AS (
    SELECT
      "加入者id" AS "加入者id",
      "加入者生年月" AS "加入者生年月",
      "加入者性別" AS "加入者性別",
      "家族id" AS "家族id",
      "本人家族コード" AS "本人家族コード",
      "本人家族" AS "本人家族",
      "続柄コード" AS "続柄コード",
      "続柄" AS "続柄",
      "観察開始年月" AS "観察開始年月",
      "観察終了年月" AS "観察終了年月",
      "観察終了理由(死亡)フラグ" AS "観察終了理由__死亡__フラグ"
    FROM source
  )

SELECT
  *
FROM renamed
