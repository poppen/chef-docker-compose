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

config_path = node['docker-compose']['config_directory']

remote_file '/usr/local/bin/docker-compose' do
  source "https://github.com/docker/compose/releases/download/#{node['docker-compose']['version']}/docker-compose-#{node[:kernel][:name]}-#{node[:kernel][:machine]}"
  mode '0755'
  owner 'root'
  group 'root'
end

directory config_path do
  mode '0755'
  owner 'root'
  group 'root'
end

node['docker-compose']['configs'].each do|config|
  config_hash = JSON.parse(config.to_json)

  file "#{config_path}/#{config_hash['name']}.yml" do
    mode '0644'
    owner 'root'
    group 'root'
    content YAML.dump(config_hash['value'])
  end
end
