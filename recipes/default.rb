#
# Cookbook Name:: docker-compose
# Recipe:: default
#
# Copyright (C) 2015 MATSUI Shinsuke
#
# All rights reserved - Do Not Redistribute
#

require 'yaml'
require 'json'

include_recipe 'docker'

config = JSON.parse(node['docker-compose']['config'].to_json)

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

if config
  file '/etc/docker-compose.d/docker-compose.yml' do
    mode '0644'
    owner 'root'
    group 'root'
    content YAML.dump(config)
  end
end

template '/etc/init/docker-compose.conf' do
  source 'docker-compose.conf.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

service 'docker-compose' do
  action [:start]
end

node['docker-compose']['registries'].each do |registry|
  docker_regigtry registry['server'] do
    email registry['email'] if registry['email']
    username registry['username'] if registry['username']
    password registry['password'] if registry['password']
  end
end
