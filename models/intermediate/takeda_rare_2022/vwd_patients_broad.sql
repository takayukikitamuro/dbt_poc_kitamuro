WITH
  import_vwd_exam_yearmonth AS (
    SELECT
      *
    FROM {{ ref('vwd_exam_yearmonth') }}
  ),

  import_vwd_suspected_yearmonth AS (
    SELECT
      *
    FROM {{ ref('vwd_suspected_yearmonth') }}
  ),

  final_cte AS (
    SELECT DISTINCT
      t1."加入者id",
      t1."診療年月",
      1 AS trt_broad_flg
    FROM
      import_vwd_exam_yearmonth AS t1
      INNER JOIN
        import_vwd_suspected_yearmonth AS t2
        ON
          (
            (CAST(t1."加入者id" AS VARCHAR) = CAST(t2."加入者id" AS VARCHAR))
            AND (CAST(t1."診療年月" AS INT) = CAST(t2."診療年月" AS INT))
          )
  )

SELECT
  *
FROM final_cte
