/* Install gitolite */

/* The step follow the instruction of gitlab. However, it should be useful for 
other software like gitweb

Verify the result:

sudo -u gitlab -H git clone git@localhost:gitolite-admin.git /tmp/gitolite-admin

Trouble shooting

1. Check the permission of /home/gitlab/.ssh/id_rsa*
*/


class precise-gitlab::gitolite($git_user,$gitlab_user) {
	
$debs = ["git-core",
		  "wget",
		  "redis-server"]

package { $debs :
    provider => apt,
    ensure => latest,
}

vcsrepo { "/home/$git_user/gitolite":
    ensure => present,
    provider => git,
    source => "https://github.com/gitlabhq/gitolite.git",
    revision => "gl-v320",
    owner => $git_user,
    require => Package["git-core"]
}

/* User for git and gitolite */

user { $git_user:
    comment => "Git Version Control",
    home => "/home/$git_user",
    shell => '/bin/bash',
    provider => "useradd",
    managehome => true, /* Create home directory */
    system => "true",
}

user { $gitlab_user:
    comment => "Gitlab",
    home => "/home/$gitlab_user",
    shell => '/bin/bash',
    provider => "useradd",
    system => "true",
    managehome => true, /* Create home directory */
    groups => ["$git_user"],
}

file { 
"/home/$gitlab_user/.ssh":
	ensure => directory,
	owner => $gitlab_user,
	group => $gitlab_user,
	mode => 700;
"/home/$git_user/gitlab.pub":
	source => "/home/$gitlab_user/.ssh/id_rsa.pub",
	owner => $git_user,
	group => $git_user,
	mode => 0444,
	require => Exec["ssh-keygen"];
"/home/$git_user/.gitolite":
	ensure => directory,
	owner => $git_user,
	group => $git_user,
	mode => 0750,
	require => Exec["gitolite setup"];
"/home/$git_user/repositories/":
	ensure => directory,
	owner => $git_user,
	group => $git_user,
	mode => "ug+rwXs,o-rwx";
}

exec { "ssh-keygen":
	command => "ssh-keygen -t rsa -f /home/$gitlab_user/.ssh/id_rsa", 
	creates => "/home/$gitlab_user/.ssh/id_rsa",
	user => $gitlab_user,
	group => $gitlab_user,
	path => "/bin:/usr/bin",
}

exec { "gitolite setup":
    command => "gitolite setup -pk /home/$git_user/gitlab.pub",
	creates => "/home/$git_user/.gitolite",
	user => $git_user,
	group => $git_user,
	cwd => "/home/$git_user",
	path => "/bin:/usr/bin:/usr/local/bin",
	environment => "HOME=/home/$git_user",
	logoutput => "true",
	require => [File["/home/$git_user/gitlab.pub"],Exec["Install gitolite"]];
"Install gitolite":
	command => "/home/$git_user/gitolite/install -ln /usr/local/bin",
	creates => "/usr/local/bin/gl-setup",
	cwd => "/home/$git_user",
	user => root,
	group => root,
	path => "/bin:/usr/bin:/usr/local/bin",
	require => Vcsrepo["/home/$git_user/gitolite"]	
}

}

