Install Gitlab on Ubuntu 12.04 via Puppet
====================================================

The project simplify the task to install Gitlab on Ubuntu 
12.04 via puppet. It give you a quick preview of Gitlab in 
VM environment which may deploy on production machine easily. 

However, if you need more advanced configuration , it is recommended
to use another project : puppet-gitlab 

https://github.com/sbadia/puppet-gitlab

Prerequisites
================

 * Any OS with vagrant / fabric and VirtualBox installed
 * Ubuntu 12.04 is recommended.

Instruction for Ubuntu
=========================

Preparation 

	sudo apt-get install fabric
	
	sudo gem install vagrant

    vagrant box add base http://files.vagrantup.com/precise64.box

Run

	cd examples/vagrant
	
	vagrant up
	
	fab init
	
	fab setup
	
Wait for few minutes , then in your browser launch:

	http://127.0.0.1:8111

Remarks: The first time connection should be very slow and may prompt "Bad Gateway" error message. May need to try few more times.

The setup has created an admin account for you. You can use the default account to login:

	admin@local.host
	5iveL!fe
