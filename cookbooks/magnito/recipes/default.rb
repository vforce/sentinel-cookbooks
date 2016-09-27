#
# Cookbook Name:: magnito
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'php'

mysql_service 'shop' do
	version '5.6'
	initial_root_password 'root'
	action [:create, :start]
end

mysql_config 'shop' do
	source 'mysql.conf.erb'
	notifies :restart, 'mysql_service[shop]'
	action :create
end
