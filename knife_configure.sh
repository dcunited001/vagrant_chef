# wow this is always my favorite f***ing part

server=http://chefserver.vm:4000
newuser=vagrant

vclientname=chef-validator
vkey=/home/vagrant/.chef/chef-validator.pem

admin=admin
adminkey=/home/vagrant/.chef/chef-webui.pem

#admin=chef-webui
#adminkey=/home/vagrant/.chef/chef-webui.pem

repo=/home/vagrant/chef-repo

knife configure --server-url $server --user $newuser --admin-client-key $adminkey --admin-client-name $admin --validation-client-name $vclientname --validation-key $vkey --repository $repo

# `knife configure --server-url $server --user $newuser
#                 --admin-client-key $adminkey
#                 --admin-client-name $admin
#                 --validation-client-name $vclientname
#                 --validation-key $vkey
#                 --repository $repo`
