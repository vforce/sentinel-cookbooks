#
# Cookbook Name:: magnito
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'php'

user='ubuntu'
group='ubuntu'

mysql_service 'shop' do
	version '5.5'
	initial_root_password 'root'
	action [:create, :start]
end

package ['git', 'inotify-tools']

docker_service 'default' do
  action [:create, :start]
end

base_folder = "/home/ubuntu"

file "#{base_folder}/git_wrapper.sh" do
	mode "0755"
	content "#!/bin/sh\nexec /usr/bin/ssh -o StrictHostKeyChecking=no -i /home/ubuntu/.ssh/id_rsa_mystique \"$@\""
end

['shop', 'mystique', 'costa'].each do |repo|
	git "#{base_folder}/#{repo}" do 
		repository "git@github.com:zalora/#{repo}.git"
		enable_submodules true
		action :sync
		revision 'master'
		ssh_wrapper "#{base_folder}/git_wrapper.sh"
		user user
		group group
	end
end

git "#{base_folder}/shop-docker" do 
	repository "git@github.com:zalora/shop-docker.git"
	enable_submodules true
	action :sync
	ssh_wrapper "#{base_folder}/git_wrapper.sh"
	user user
	group group
	revision 'improve-shop-docker'
end

shop_docker_folder = "#{base_folder}/shop-docker"

execute "init docker" do
	command "/bin/bash #{shop_docker_folder}/init-chef.sh"
	cwd shop_docker_folder
	live_stream true
	user user
	group group
end
