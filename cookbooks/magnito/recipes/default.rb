#
# Cookbook Name:: magnito
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'php'

mysql_service 'shop' do
	version '5.5'
	initial_root_password 'root'
	action [:create, :start]
end

package ['git']

docker_service 'default' do
  action [:create, :start]
end

base_folder = "/home/ubuntu"

file "#{base_folder}/git_wrapper.sh" do
	mode "0755"
	content "#!/bin/sh\nexec /usr/bin/ssh -o StrictHostKeyChecking=no -i /home/ubuntu/.ssh/id_rsa_mystique \"$@\""
end

['shop', 'shop-docker', 'mystique', 'costa'].each do |repo|
	git "#{base_folder}/#{repo}" do 
		repository "git@github.com:zalora/#{repo}.git"
		enable_submodules true
		action :sync
		revision 'master'
		ssh_wrapper "#{base_folder}/git_wrapper.sh"
	end
end

bash 'init docker' do
	cwd "#{base_folder}/shop-docker"
	code "init.sh"
	ignore_failure false
end
