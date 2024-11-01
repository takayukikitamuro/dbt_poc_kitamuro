WITH
  actdata AS (
    SELECT
      *
    FROM {{ ref('stg_jmdc_actdata') }}
  ),

  final AS (
    SELECT DISTINCT
      actdata."加入者id" AS "加入者id",
      actdata."診療年月" AS "診療年月"
    FROM
      actdata
    WHERE
      actdata."標準化診療行為コード" IN (160015310, 160124650)
  )

SELECT
  *
FROM final
