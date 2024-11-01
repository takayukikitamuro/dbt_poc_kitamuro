WITH
  import_vwd_patients_broad AS (
    SELECT
      *
    FROM {{ ref('vwd_patients_broad') }}
  ),

  import_vwd_patients_standard AS (
    SELECT
      *
    FROM {{ ref('vwd_patients_standard') }}
  ),

  import_vwd_patients_narrow AS (
    SELECT
      *
    FROM {{ ref('vwd_patients_narrow') }}
  ),

  final_cte AS (
    SELECT
      t1.trt_broad_flg,
      t2.trt_standard_flg,
      t3.trt_narrow_flg,
      COALESCE(t1."加入者id", t2."加入者id", t3."加入者id") AS "加入者id",
      COALESCE(
        CAST(t1."診療年月" AS BIGINT),
        CAST(t2."診療年月" AS BIGINT),
        CAST(t3."診療年月" AS BIGINT)
      ) AS "診療年月",
      (
        CASE
          WHEN
            (
              t1."診療年月"
              = MIN(
                (
                  CASE
                    WHEN (t1.trt_broad_flg = 1) THEN t1."診療年月"
                  END
                )
              )
                OVER (
                  PARTITION BY
                    COALESCE(t1."加入者id", t2."加入者id", t3."加入者id")
                )
            )
            THEN 1
          ELSE 0
        END
      ) AS new_broad_flg,
      (
        CASE
          WHEN
            (
              t2."診療年月"
              = MIN(
                (
                  CASE
                    WHEN
                      (t2.trt_standard_flg = 1)
                      THEN t2."診療年月"
                  END
                )
              )
                OVER (
                  PARTITION BY
                    COALESCE(t1."加入者id", t2."加入者id", t3."加入者id")
                )
            )
            THEN 1
          ELSE 0
        END
      ) AS new_standard_flg,
      (
        CASE
          WHEN
            (
              t3."診療年月"
              = MIN(
                (
                  CASE
                    WHEN (t3.trt_narrow_flg = 1) THEN t3."診療年月"
                  END
                )
              )
                OVER (
                  PARTITION BY
                    COALESCE(t1."加入者id", t2."加入者id", t3."加入者id")
                )
            )
            THEN 1
          ELSE 0
        END
      ) AS new_narrow_flg
    FROM
      import_vwd_patients_broad AS t1
      FULL JOIN
        import_vwd_patients_standard AS t2
        ON
          (
            (CAST(t1."加入者id" AS VARCHAR) = CAST(t2."加入者id" AS VARCHAR))
            AND (CAST(t1."診療年月" AS BIGINT) = CAST(t2."診療年月" AS BIGINT))
          )
      FULL JOIN
        import_vwd_patients_narrow AS t3
        ON
          (
            (
              CAST(COALESCE(t1."加入者id", t2."加入者id") AS VARCHAR)
              = CAST(t3."加入者id" AS VARCHAR)
            )
            AND (
              CAST(
                COALESCE(
                  CAST(t1."診療年月" AS BIGINT), CAST(t2."診療年月" AS BIGINT)
                ) AS BIGINT
              )
              = CAST(t3."診療年月" AS BIGINT)
            )
          )
  )

SELECT
  *
FROM final_cte
