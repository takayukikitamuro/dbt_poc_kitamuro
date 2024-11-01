WITH
  import_vwd_paneldata_wrk2 AS (
    SELECT
      *
    FROM {{ ref('vwd_paneldata_wrk2') }}
  ),

  final_cte AS (
    SELECT
      "加入者id" AS "加入者id",
      "診療年月" AS "診療年月",
      sex,
      -- age,
      "観察終了年月" AS obs_enddate,
      "観察終了理由__死亡__フラグ" AS enddate_death_flg,
      visit,
      adm,
      trt_broad_flg,
      new_broad_flg,
      trt_standard_flg,
      new_standard_flg,
      trt_narrow_flg,
      new_narrow_flg,
      YEAR(CAST(DATE_PARSE(CAST("診療年月" AS VARCHAR), '%y%m') AS TIMESTAMP)) AS yyyy,
      MONTH(CAST(DATE_PARSE(CAST("診療年月" AS VARCHAR), '%y%m') AS TIMESTAMP)) AS mm,
      (
        CASE
          WHEN (age < 5) THEN '0-4' WHEN ((age >= 5) AND (age < 10)) THEN '5-9' WHEN
            ((age >= 10) AND (age < 15))
            THEN '10-14'
          WHEN ((age >= 15) AND (age < 20)) THEN '15-19' WHEN ((age >= 20) AND (age < 25)) THEN '20-24' WHEN
            ((age >= 25) AND (age < 30))
            THEN '25-29'
          WHEN ((age >= 30) AND (age < 35)) THEN '30-34' WHEN ((age >= 35) AND (age < 40)) THEN '35-39' WHEN
            ((age >= 40) AND (age < 45))
            THEN '40-44'
          WHEN ((age >= 45) AND (age < 50)) THEN '45-49' WHEN ((age >= 50) AND (age < 55)) THEN '50-54' WHEN
            ((age >= 55) AND (age < 60))
            THEN '55-59'
          WHEN ((age >= 60) AND (age < 65)) THEN '60-64' WHEN ((age >= 65) AND (age < 70)) THEN '65-69' WHEN
            ((age >= 70) AND (age < 75))
            THEN '70-74'
          ELSE '75+'
        END
      ) AS age_group,
      (CASE WHEN ((sex = '男性') AND (age < 5)) THEN 1 ELSE 0 END) AS male_age_group_0to4_flg,
      (CASE WHEN ((sex = '女性') AND (age < 5)) THEN 1 ELSE 0 END) AS female_age_group_0to4_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 5)) AND (age < 10)) THEN 1 ELSE 0 END) AS male_age_group_5to9_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 5)) AND (age < 10)) THEN 1 ELSE 0 END) AS female_age_group_5to9_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 10)) AND (age < 15)) THEN 1 ELSE 0 END) AS male_age_group_10to14_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 10)) AND (age < 15)) THEN 1 ELSE 0 END) AS female_age_group_10to14_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 15)) AND (age < 20)) THEN 1 ELSE 0 END) AS male_age_group_15to19_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 15)) AND (age < 20)) THEN 1 ELSE 0 END) AS female_age_group_15to19_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 20)) AND (age < 25)) THEN 1 ELSE 0 END) AS male_age_group_20to24_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 20)) AND (age < 25)) THEN 1 ELSE 0 END) AS female_age_group_20to24_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 25)) AND (age < 30)) THEN 1 ELSE 0 END) AS male_age_group_25to29_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 25)) AND (age < 30)) THEN 1 ELSE 0 END) AS female_age_group_25to29_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 30)) AND (age < 35)) THEN 1 ELSE 0 END) AS male_age_group_30to34_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 30)) AND (age < 35)) THEN 1 ELSE 0 END) AS female_age_group_30to34_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 35)) AND (age < 40)) THEN 1 ELSE 0 END) AS male_age_group_35to39_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 35)) AND (age < 40)) THEN 1 ELSE 0 END) AS female_age_group_35to39_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 40)) AND (age < 45)) THEN 1 ELSE 0 END) AS male_age_group_40to44_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 40)) AND (age < 45)) THEN 1 ELSE 0 END) AS female_age_group_40to44_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 45)) AND (age < 50)) THEN 1 ELSE 0 END) AS male_age_group_45to49_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 45)) AND (age < 50)) THEN 1 ELSE 0 END) AS female_age_group_45to49_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 50)) AND (age < 55)) THEN 1 ELSE 0 END) AS male_age_group_50to54_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 50)) AND (age < 55)) THEN 1 ELSE 0 END) AS female_age_group_50to54_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 55)) AND (age < 60)) THEN 1 ELSE 0 END) AS male_age_group_55to59_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 55)) AND (age < 60)) THEN 1 ELSE 0 END) AS female_age_group_55to59_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 60)) AND (age < 65)) THEN 1 ELSE 0 END) AS male_age_group_60to64_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 60)) AND (age < 65)) THEN 1 ELSE 0 END) AS female_age_group_60to64_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 65)) AND (age < 70)) THEN 1 ELSE 0 END) AS male_age_group_65to69_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 65)) AND (age < 70)) THEN 1 ELSE 0 END) AS female_age_group_65to69_flg,
      (CASE WHEN (((sex = '男性') AND (age >= 70)) AND (age < 75)) THEN 1 ELSE 0 END) AS male_age_group_70to74_flg,
      (CASE WHEN (((sex = '女性') AND (age >= 70)) AND (age < 75)) THEN 1 ELSE 0 END) AS female_age_group_70to74_flg
    FROM
      import_vwd_paneldata_wrk2
    ORDER BY
      "加入者id" ASC,
      "診療年月" ASC
  )

SELECT
  *
FROM final_cte
