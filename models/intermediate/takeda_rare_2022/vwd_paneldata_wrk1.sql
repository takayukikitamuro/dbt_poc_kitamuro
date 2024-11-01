WITH
  import_vwd_diagnostic_flag AS (
    SELECT
      *
    FROM {{ ref('vwd_diagnostic_flag') }}
  ),

  import_vwd_visit_adm AS (
    SELECT
      *
    FROM {{ ref('vwd_visit_adm') }}
  ),

  final_cte AS (
    SELECT
      t1.trt_broad_flg,
      t1.new_broad_flg,
      t1.trt_standard_flg,
      t1.new_standard_flg,
      t1.trt_narrow_flg,
      t1.new_narrow_flg,
      t2.visit,
      t2.adm,
      COALESCE(t1."加入者id", t2."加入者id") AS "加入者id",
      COALESCE(CAST(t1."診療年月" AS BIGINT), CAST(t2."診療年月" AS BIGINT))
        AS "診療年月"
    FROM
      import_vwd_diagnostic_flag AS t1
      FULL JOIN
        import_vwd_visit_adm AS t2
        ON
          (
            (CAST(t1."加入者id" AS VARCHAR) = CAST(t2."加入者id" AS VARCHAR))
            AND (CAST(t1."診療年月" AS INT) = CAST(t2."診療年月" AS INT))
          )
  )

SELECT
  *
FROM final_cte
