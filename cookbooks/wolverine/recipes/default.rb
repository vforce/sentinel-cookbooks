#
# Cookbook Name:: wolverine
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

template '~/.vimrc' do
	source 'vimrc.erb'
	action :create
end
