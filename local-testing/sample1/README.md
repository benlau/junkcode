Example code for an article at http://goo.gl/yt2Ms
================

Prerequisites
================

 * Ubuntu 12.04 or above (11.10 should also be working , but not tested)

Instruction
================

Preparation 

	sudo apt-get install fabric ubuntu-vm-builder

If you don't have your ssh key, create it by :
	
	ssh-keygen -t dsa

Run

	cd deploy

	fab create

	fab start

	fab setup

	fab deploy

In another terminal

	fab view

