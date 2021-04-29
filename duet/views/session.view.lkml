view: session {
  sql_table_name: `moz-fx-data-marketing-prod.ga_derived.www_site_metrics_summary_v1`
    ;;

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: downloads {
    hidden: yes
    type: number
    sql: ${TABLE}.downloads ;;
  }

  dimension: non_fx_downloads {
    hidden: yes
    type: number
    sql: ${TABLE}.non_fx_downloads ;;
  }

  dimension: non_fx_sessions {
    hidden: yes
    type: number
    sql: ${TABLE}.non_fx_sessions ;;
  }

  dimension: operating_system {
    hidden: yes
    type: string
    sql: ${TABLE}.operating_system ;;
  }

  dimension: sessions {
    hidden: yes
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: standardized_country_name {
    hidden: yes
    type: string
    sql: ${TABLE}.standardized_country_name ;;
  }

  filter: date {
    type: date
  }

  parameter: previous_time_period {
    type: yesno
    description: "Flag to determine whether data from the previous time period should be used. For example, if the date filter is set to the previous 7 days, then the 7 days before that will be used instead."
    default_value: "no"
  }

  parameter: ignore_most_recent_week {
    label: "Ignore Most Recent Week"
    type: yesno
    description: "Ignore data from the most recent week. For example, activations are always a week behind."
    default_value: "no"
  }

  dimension: join_date {
    description: "Date used for joining sessions from different time periods."
    type: date
    sql: IF({% parameter previous_time_period %}, DATE(DATE_SUB(${date_date}, INTERVAL DATE_DIFF(DATE({% date_start date %}), DATE({% date_end date %}), DAY) DAY)), ${date_date}) ;;
  }

  measure: total_non_fx_sessions {
    description: "Total visits from non-Firefox browsers."
    type: sum
    sql: ${TABLE}.non_fx_sessions ;;
  }

  measure: total_non_fx_downloads {
    description: "Total downloads from non-Firefox browsers."
    type: sum
    sql: ${TABLE}.non_fx_downloads ;;
  }
}
