include: "//looker-hub/firefox_desktop/views/clients_last_seen.view.lkml"

view: client_properties {
  extends: [clients_last_seen]

  filter: days_diff {
    type: number
    default_value: "0"
  }

  measure: count_is_default_browser {
    type: count

    filters: [is_default_browser: "yes"]
  }

  measure: count_clients {
    label: "Count Clients"
    type: count
  }

  measure: fraction_is_default_browser {
    sql: SAFE_DIVIDE(${count_is_default_browser}, ${count_clients}) ;;
    type: number
  }
}
