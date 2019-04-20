#
# Cookbook:: myaccount
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

user 'gdha' do
  uid '501'
  gid 'users'
  shell '/bin/bash'
  action :create
  manage_home true
end

group 'users' do
  action :modify
  members 'gdha'
  append true
end
