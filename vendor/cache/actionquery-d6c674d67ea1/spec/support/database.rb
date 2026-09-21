# frozen_string_literal: true

require "active_record"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Schema.verbose = false

ActiveRecord::Schema.define do
  create_table :users, force: true do |table|
    table.string :name, null: false
    table.text :biography
    table.integer :age
    table.decimal :balance, precision: 10, scale: 2
    table.boolean :active, default: false, null: false
    table.date :birthday
    table.datetime :signed_in_at
    table.integer :status, default: 0, null: false
    table.json :metadata
    table.timestamps
  end

  create_table :admin_users, force: true do |table|
    table.string :name, null: false
  end

  create_table :external_records, id: false, force: true do |table|
    table.string :code, null: false, primary_key: true
    table.string :name, null: false
  end
end
