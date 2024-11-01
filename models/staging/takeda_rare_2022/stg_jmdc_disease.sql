WITH
  source AS (
    SELECT
      *
    FROM {{ source('takeda', 'jmdc_disease') }}
  ),

  renamed AS (
    SELECT
      "加入者id" AS "加入者id",
      "レセid" AS "レセid",
      "明細id" AS "明細id",
      "レセ種別" AS "レセ種別",
      "診療年月" AS "診療年月",
      "医療施設id" AS "医療施設id",
      "標準傷病コード" AS "標準傷病コード",
      "標準病名" AS "標準病名",
      "主傷病フラグ" AS "主傷病フラグ",
      "入院の契機となった傷病フラグ" AS "入院の契機となった傷病フラグ",
      "疑いフラグ" AS "疑いフラグ",
      "診療開始年月日" AS "診療開始年月日",
      "転帰" AS "転帰",
      "死亡フラグ" AS "死亡フラグ",
      "増悪フラグ" AS "増悪フラグ"
    FROM source
  )

SELECT
  *
FROM renamed
