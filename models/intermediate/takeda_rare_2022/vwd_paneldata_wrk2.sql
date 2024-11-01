WITH
  import_vwd_paneldata_wrk1 AS (
    SELECT
      *
    FROM {{ ref('vwd_paneldata_wrk1') }}
  ),

  import_patient AS (
    SELECT
      *
    FROM {{ ref('stg_jmdc_patient') }}
  ),

  final_cte AS (
    SELECT
      t1."加入者id",
      t1."加入者生年月",
      t1."加入者性別" AS sex,
      t0."診療年月",
      t1."観察終了年月",
      t1."観察終了理由__死亡__フラグ",
      t0.visit,
      t0.adm,
      t0.trt_broad_flg,
      t0.new_broad_flg,
      t0.trt_standard_flg,
      t0.new_standard_flg,
      t0.trt_narrow_flg,
      t0.new_narrow_flg
      -- DATE_DIFF(
      --   'year',
      --   CAST(
      --     DATE_PARSE(CAST(t1."加入者生年月" AS VARCHAR), '%y%m') AS TIMESTAMP
      --   ),
      --   CAST(DATE_PARSE(CAST(t0."診療年月" AS VARCHAR), '%y%m') AS TIMESTAMP)
      -- ) AS age
    FROM
      import_vwd_paneldata_wrk1 AS t0
      LEFT JOIN
        import_patient AS t1
        ON (t0."加入者id" = t1."加入者id")
  )

SELECT
  *
FROM final_cte
