#!/bin/bash

# Create a new database (folder)
create_database() {
  local db_name="$1"
  if [ -d "$db_name" ]; then
    echo "Database $db_name already exists."
  else
    mkdir "$db_name"
    echo "Database $db_name created successfully."
  fi
}

# Create a new table (file) inside a database
create_table() {
  local db_name="$1"
  local table_name="$2"
  if [ -d "$db_name" ]; then
    if [ -f "$db_name/$table_name" ]; then
      echo "Table $table_name already exists in database $db_name."
    else
      touch "$db_name/$table_name"
      echo "Table $table_name created successfully in database $db_name."
    fi
  else
    echo "Database $db_name does not exist."
  fi
}
# Add a new row (record) to a table
add_row() {
  local db_name="$1"
  local table_name="$2"
  local row_data="$3"
  if [ -f "$db_name/$table_name" ]; then
    echo "$row_data" >> "$db_name/$table_name"
    echo "Row added to table $table_name in database $db_name."
  else
    echo "Table $table_name does not exist in database $db_name."
  fi
}

# Delete a row by matching the exact row data
delete_row() {
  local db_name="$1"
  local table_name="$2"
  local row_data="$3"
  if [ -f "$db_name/$table_name" ]; then
    grep -v "^$row_data$" "$db_name/$table_name" > "$db_name/${table_name}_temp"
    mv "$db_name/${table_name}_temp" "$db_name/$table_name"
    echo "Row deleted from table $table_name in database $db_name."
  else
    echo "Table $table_name does not exist in database $db_name."
  fi
}

# Update a row by matching the old data and replacing it with new data
update_row() {
  local db_name="$1"
  local table_name="$2"
  local old_data="$3"
  local new_data="$4"
  if [ -f "$db_name/$table_name" ]; then
    sed -i "s/^$old_data$/$new_data/" "$db_name/$table_name"
    echo "Row updated in table $table_name in database $db_name."
  else
    echo "Table $table_name does not exist in database $db_name."
  fi
}

case "$1" in
  create_database)
    create_database "$2"
    ;;
  create_table)
    create_table "$2" "$3"
    ;;
  add_row)
    add_row "$2" "$3" "$4"
    ;;
  delete_row)
    delete_row "$2" "$3" "$4"
    ;;
  update_row)
    update_row "$2" "$3" "$4" "$5"
    ;;
  *)
    echo "Usage: $0 {create_database|create_table|add_row|delete_row|update_row}"
    ;;
esac
