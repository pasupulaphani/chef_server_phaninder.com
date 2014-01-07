#
# Cookbook Name:: phaninder.com
# Recipe:: default
#
# Copyright 2013, phaninder.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

template "/etc/nginx/sites-available/#{node[:myblog][:name]}" do
	source "#{node[:myblog][:name]}.erb"
	owner "root"
	group "root"
	mode 00644
	notifies :restart, 'service[nginx]'
end

link "/etc/nginx/sites-enabled/#{node[:myblog][:name]}" do
  filename = "/etc/nginx/sites-available/#{node[:myblog][:name]}"
  to filename
  only_if { File.exists? filename }
end

service "nginx" do
	supports :restart => true, :status => true
	action [:enable, :start]
end