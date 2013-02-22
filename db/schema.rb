# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121030105646) do

  create_table "applets", :force => true do |t|
    t.string   "name"
    t.string   "icon"
    t.string   "path"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "applets", ["name"], :name => "index_applets_on_name", :unique => true

  create_table "audits", :force => true do |t|
    t.string   "user"
    t.datetime "datetime"
    t.text     "message"
    t.string   "origin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "features", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "code"
    t.integer  "stat"
    t.string   "hsh"
    t.string   "expiry"
    t.integer  "max_user"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "features", ["code"], :name => "index_features_on_code", :unique => true

  create_table "filters", :force => true do |t|
    t.string   "name"
    t.string   "group"
    t.string   "pattern"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "filters", ["name", "group", "pattern"], :name => "index_filters_on_name_and_group_and_pattern", :unique => true

  create_table "jobs", :force => true do |t|
    t.integer  "taskId"
    t.datetime "task_created_at"
    t.integer  "userId"
    t.string   "name"
    t.string   "category"
    t.integer  "status"
    t.datetime "schedule"
    t.integer  "recurrence"
    t.text     "message"
    t.string   "logFile"
    t.datetime "startTime"
    t.datetime "endTime"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "jobs", ["taskId", "task_created_at"], :name => "index_jobs_on_taskId_and_task_created_at", :unique => true

  create_table "konfigs", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.string   "owner"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "konfigs", ["key", "value", "owner"], :name => "index_konfigs_on_key_and_value_and_owner", :unique => true

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id"], :name => "index_microposts_on_user_id"

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.string   "ip"
    t.integer  "port"
    t.integer  "port2"
    t.integer  "port3"
    t.integer  "port4"
    t.string   "user"
    t.string   "pass"
    t.string   "user2"
    t.string   "pass2"
    t.string   "user3"
    t.string   "pass3"
    t.string   "user4"
    t.string   "pass4"
    t.string   "klass"
    t.string   "serverModel"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "nodes", ["name", "ip", "klass"], :name => "index_nodes_on_name_and_ip_and_klass", :unique => true

  create_table "permissions", :force => true do |t|
    t.integer  "role_id"
    t.integer  "right_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "permissions", ["role_id", "right_id"], :name => "index_permissions_on_role_id_and_right_id", :unique => true

  create_table "right_applets", :force => true do |t|
    t.integer  "right_id"
    t.integer  "applet_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "right_applets", ["right_id", "applet_id"], :name => "index_right_applets_on_right_id_and_applet_id", :unique => true

  create_table "rights", :force => true do |t|
    t.string   "controller"
    t.string   "action"
    t.integer  "policy"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rights", ["controller", "action"], :name => "index_rights_on_controller_and_action", :unique => true

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["user_id", "role_id"], :name => "index_user_roles_on_user_id_and_role_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "pswd"
    t.string   "salt"
    t.datetime "expiry"
    t.datetime "account_expiry"
    t.integer  "failed",         :default => 0
    t.boolean  "lock"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
