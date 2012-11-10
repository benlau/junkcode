from __future__ import with_statement
from fabric.api import local, settings, abort, run, cd , put
from fabric.contrib.console import confirm
from fabric.api import env
from fabric.context_managers import prefix

def _getIp(name):
    # Get the IP address of a testing machine
    file = open("/var/lib/libvirt/dnsmasq/default.leases")
    for line in file:
        token = line.split(" ")
        if (token[3] == name):
            return token[2]
    return None

machine = "nodejs" # Name of the testing machine

ip = _getIp(machine)
if ip != None:
	env.hosts = [ip]
env.user = "root"

def create():
    # Create a testing machine
    
    # Remarks: You should not permit root logins via SSH in a networking 
    # environment, because this is a big and unnecessary security risk.
    #
    # It is enabled here for simplify the tasks required to build 
    # a testing machine. Never do it in production and even on 
    # a machine within your office network.
    
    dist = "precise"
    mem = 128
    
    packages = ["openssh-server" , "puppet" , "nodejs" ,"npm"]
    package = " ".join([ "--addpkg %s"  % x for x in packages]);
    
    options = ["--libvirt qemu:///system", # Add to libvirt
                "--lang=C",  
                "--ssh-key ~/.ssh/id_dsa.pub",
                "-d /var/lib/libvirt/images/%s" % machine,
                "--hostname %s" % machine,
                "--mem=%s" % mem,
                "--name=%s" % machine ]
    option = " ".join(options);

    command = "sudo ubuntu-vm-builder kvm %s qemu:///system %s %s" % (dist , package,option)
    local(command)   

def start():
    local("sudo virsh start %s" % machine)
    
def setup():
    # Setup the testing machine using puppet
    put("setup*.pp" ,"/tmp")
    run("puppet apply /tmp/setup-phase1.pp")
    run("puppet apply /tmp/setup-phase2.pp")

def deploy():
    # Deploy the script to testing server and execute it.
    
    # To make it simple , it didn't use anything like upstart.
    # And the execution of node.js is blocked , you may terminate it
    # by ctrl+c in your local machine.
    
    put("../src/nodeload-server.js","/tmp")
    run("killall -9 node;echo")
    with prefix("export NODE_PATH=/usr/local/lib/node_modules:/usr/lib/nodejs"):
        run("node /tmp/nodeload-server.js ")

def view():
    # View the testing site by browser
    local("xdg-open http://%s:8000" % _getIp(machine))

