# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'applet'
require 'right'
require 'role'
require 'feature'
require 'right_applet'
require 'permission'
require 'user'
require 'user_role'


puts 'Seeding initial Konfigs to DB'

puts "Creating applets"
#Applet.destroy_all
aplUsr = Applet.find_or_create_by_name( name: 'User Admin', icon: 'users_l.png', path: '/admin/users', description: 'User Administration' )
aplNode = Applet.find_or_create_by_name( name: 'Node Admin', icon: 'nodes_s.png', path: '/admin/nodes', description: 'Node Administration' )
aplRole = Applet.find_or_create_by_name :name => 'Role', :icon => 'role_s.png', :path => '/admin/roles', :description => 'Role'
aplAudit = Applet.find_or_create_by_name :name => 'Audit', :icon => 'audit_s.png', :path => '/admin/audits', :description => 'Audit'
aplKonfig = Applet.find_or_create_by_name :name => 'Settings', :icon => 'configuration_s.png', :path => '/admin/konfigs', :description => 'RIRA Configurations'
aplFilter = Applet.find_or_create_by_name :name => 'Filters', :icon => 'filter_s.png', :path => '/filters', :description => 'Filters'
aplJob = Applet.find_or_create_by_name :name => 'Jobs', :icon => 'job_s.png', :path => '/jobs', :description => 'Background Jobs'


puts "Creating rights"
#Right.destroy_all
Right.find_or_create_by_controller_and_action :controller => 'rights', :action => 'index'
Right.find_or_create_by_controller_and_action :controller => 'rights', :action => 'new'
Right.find_or_create_by_controller_and_action :controller => 'rights', :action => 'edit'
Right.find_or_create_by_controller_and_action :controller => 'rights', :action => 'update'
Right.find_or_create_by_controller_and_action :controller => 'rights', :action => 'create'
Right.find_or_create_by_controller_and_action :controller => 'rights', :action => 'show'
Right.find_or_create_by_controller_and_action :controller => 'rights', :action => 'destroy'

r = Right.find_or_create_by_controller_and_action :controller => 'roles', :action => 'index', :applet_ids => aplRole.id
r.applet_ids = aplRole.id
Right.find_or_create_by_controller_and_action :controller => 'roles', :action => 'new'
Right.find_or_create_by_controller_and_action :controller => 'roles', :action => 'edit'
Right.find_or_create_by_controller_and_action :controller => 'roles', :action => 'update'
Right.find_or_create_by_controller_and_action :controller => 'roles', :action => 'create'
Right.find_or_create_by_controller_and_action :controller => 'roles', :action => 'show'
Right.find_or_create_by_controller_and_action :controller => 'roles', :action => 'destroy'

r = Right.find_or_create_by_controller_and_action :controller => 'audits', :action => 'show', :applet_ids => aplAudit.id
r.applet_ids = aplAudit.id
Right.find_or_create_by_controller_and_action :controller => 'audits', :action => 'index'

r = Right.find_or_create_by_controller_and_action :controller => 'konfigs', :action => 'index', :applet_ids => aplKonfig.id
r.applet_ids = aplKonfig.id
Right.find_or_create_by_controller_and_action :controller => 'konfigs', :action => 'new'
Right.find_or_create_by_controller_and_action :controller => 'konfigs', :action => 'edit'
Right.find_or_create_by_controller_and_action :controller => 'konfigs', :action => 'update'
Right.find_or_create_by_controller_and_action :controller => 'konfigs', :action => 'create'
Right.find_or_create_by_controller_and_action :controller => 'konfigs', :action => 'show'
Right.find_or_create_by_controller_and_action :controller => 'konfigs', :action => 'destroy'

r = Right.find_or_create_by_controller_and_action :controller => 'nodes', :action => 'index', :applet_ids => aplNode.id
r.applet_ids = aplNode.id
Right.find_or_create_by_controller_and_action :controller => 'nodes', :action => 'new'
Right.find_or_create_by_controller_and_action :controller => 'nodes', :action => 'edit'
Right.find_or_create_by_controller_and_action :controller => 'nodes', :action => 'update'
Right.find_or_create_by_controller_and_action :controller => 'nodes', :action => 'create'
Right.find_or_create_by_controller_and_action :controller => 'nodes', :action => 'show'
Right.find_or_create_by_controller_and_action :controller => 'nodes', :action => 'destroy'

r = Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'index', :applet_ids => aplUsr.id
r.applet_ids = aplUsr.id
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'new'
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'edit'
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'update'
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'create'
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'show'
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'destroy'
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'lock'
Right.find_or_create_by_controller_and_action :controller => 'users', :action => 'unlock'

r = Right.find_or_create_by_controller_and_action :controller => 'filters', :action => 'index', :applet_ids => aplFilter.id
r.applet_ids = aplFilter.id
Right.find_or_create_by_controller_and_action :controller => 'filters', :action => 'new'
Right.find_or_create_by_controller_and_action :controller => 'filters', :action => 'edit'
Right.find_or_create_by_controller_and_action :controller => 'filters', :action => 'update'
Right.find_or_create_by_controller_and_action :controller => 'filters', :action => 'create'
Right.find_or_create_by_controller_and_action :controller => 'filters', :action => 'show'
Right.find_or_create_by_controller_and_action :controller => 'filters', :action => 'destroy'

r = Right.find_or_create_by_controller_and_action :controller => 'jobs', :action => 'index', :applet_ids => aplJob.id
r.applet_ids = aplJob.id
Right.find_or_create_by_controller_and_action :controller => 'jobs', :action => 'show'

Right.find_or_create_by_controller_and_action :controller => 'user_settings', :action => 'edit'
Right.find_or_create_by_controller_and_action :controller => 'user_settings', :action => 'update'

Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'index'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'new'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'enable'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'disable'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'refresh'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'update'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'create'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'show'
Right.find_or_create_by_controller_and_action :controller => 'features', :action => 'destroy'

puts "Creating roles"
#Role.destroy_all
radminRole = Role.find_or_create_by_name :name => 'radmin', :description => 'GOD', :right_ids => Right.pluck(:id)
radminRole.rights = Right.all

puts "Adding radmin"
#User.destroy( User.find_by_name( 'radmin' ) )
radmin = User.find_or_create_by_email email: 'radmin@rira.app', name: 'radmin', roles: [radminRole], password: 'radmin', password_confirmation: 'radmin'
radmin.roles = [radminRole]


puts "Adding default features"
# Adding Default Licenses
#Feature.destroy_all
#Feature.find_or_create_by_code :name => 'SubDA Text View', :description => 'Sub Dedicated Account Text View', :code => 'RF-V1001', :expiry => 'no expiry', :max_user => 0, :hsh => '1aef35c606fbff22a5dde8d67a3ceff3bf0fecea88dfa212d537021076079838'
#Feature.find_or_create_by_code :name => 'SubDA Graph View', :description => 'Sub Dedicated Account Graph View', :code => 'RF-V1002', :expiry =>  'no expiry', :max_user => 0, :hsh => 'e51a24e80c35f11f6c0a01ec01b487bbd44c018ca096f038b302ad6672865ce1'

