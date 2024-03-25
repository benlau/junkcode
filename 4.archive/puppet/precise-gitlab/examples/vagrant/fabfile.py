# Install Gitlab on Vagrant's Ubuntu 12.04 package

from __future__ import with_statement
from fabric.api import local, settings, abort, run, cd , put , open_shell
from fabric.contrib.console import confirm
from fabric.api import env
from fabric.context_managers import prefix

def vagrant():
    env.user = 'vagrant'
    # connect to the port-forwarded ssh
    env.hosts = ['127.0.0.1:7111']
 
    # use vagrant ssh key
    result = local('vagrant ssh-config | grep IdentityFile', capture=True)
    env.key_filename = result.split()[1]

vagrant()

def upload():
    run("sudo mkdir -p /etc/puppet/modules/precise-gitlab")
    run("sudo chown -R vagrant:vagrant /etc/puppet/modules/precise-gitlab")
    put("../../*","/etc/puppet/modules/precise-gitlab")
   
def init():
	# Initialize the machine. This function should only be called once
	upload()
	with cd("/etc/puppet/modules/precise-gitlab/examples/vagrant"):
		run("sudo puppet apply init1.pp")
		run("sudo puppet apply init2.pp")
		run("sudo puppet apply init3.pp")
   
def setup():
    # Install gitlab and customize the environment.
    # May call for multiple times to adjust the setting
    upload()
    with cd("/etc/puppet/modules/precise-gitlab/examples/vagrant"):
        run("sudo puppet apply setup.pp")

