#
# Cookbook Name:: docker-compose
# Recipe:: default
#
# Copyright (C) 2015 MATSUI Shinsuke
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

remote_file '/usr/local/bin/docker-compose' do
  source "https://github.com/docker/compose/releases/download/#{node['docker-compose']['version']}/docker-compose-#{node[:kernel][:name]}-#{node[:kernel][:machine]}"
  mode '0755'
  owner 'root'
  group 'root'
end

directory '/etc/docker-compose.d' do
  path node['docker-compose']['config_directory']
  mode '0755'
  owner 'root'
  group 'root'
end

file '/etc/docker-compose.d/docker-compose.yml' do
end

template '/etc/init/docker-compose.conf' do
  source 'docker-compose.conf.erb'
  mode '0600'
  owner 'root'
  group 'root'
end

# todo
service 'docker-compose' do
  #provier
  #supports :start => true, :restart => true, :reload => true
  #action [:start]
end
