#
# Cookbook Name:: magnito
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'php'

mysql_service 'default' do
	version '5.5'
	initial_root_password 'root'
	action [:create, :start]
end

mysql_config 'default' do
	source 'mysql.conf.erb'
	notifies :restart, 'mysql_service[shop]'
	action :create
end

package ['git']

docker_service 'default' do
  action [:create, :start]
end
