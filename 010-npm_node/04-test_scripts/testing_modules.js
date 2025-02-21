const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path')
const { insert_col, filter_column_headers, remove_last_subtotal, filter_section_column, filter_extra_descriptions, filter_below_match, filter_below_match_flex, filter_above_match, contract_filter, filter_data_in_wrong_column, export_data, import_data, normalize_contract_names, batch_contract_clean } = require("./contract_db_import.js");

batch_contract_clean();

