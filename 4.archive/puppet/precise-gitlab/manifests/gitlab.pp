
class precise-gitlab::gitlab($git_user,
							     $git_group,
								 $gitlab_user,
								 $gitlab_group,
								 $gitlab_dbuser,
								 $gitlab_dbpwd,
								 $gitlab_dbname,
								 $gitlab_home,
								 $git_server_addr,
								 $git_server_port
								) {

  $gitlab_src = "$gitlab_home/gitlab"
  $gitlab_dbtype = mysql

  require gitlab::nginx

  class {"precise-gitlab::gitolite":
	  git_user => $git_user,
	  gitlab_user => $gitlab_user
  }

  class { 'mysql::server': }
  
  mysql::db {
    $gitlab_dbname:
      ensure   => 'present',
      charset  => 'utf8',
      user     => $gitlab_dbuser,
      password => $gitlab_dbpwd,
      host     => 'localhost',
      grant    => ['all'],
      # See http://projects.puppetlabs.com/issues/17802 (thanks Elliot)
      require  => Class['mysql::config'],
  }

  vcsrepo { "$gitlab_src" : 
    ensure => present,
    provider => git,
    source => "https://github.com/gitlabhq/gitlabhq.git",
    revision => "4-1-stable",
    owner => gitlab
  }  

  file {
	  "${gitlab_home}/gitlab/config/gitlab.yml":
         ensure  => present,
         #source => "${gitlab_home}/gitlab/config/gitlab.yml.example",
         content => template("precise-gitlab/gitlab.yml.erb"),
         owner   => $gitlab_user,
         group   => $gitlab_user,
         mode    => '0640',
         require => Vcsrepo[$gitlab_src];
    "${gitlab_home}/gitlab/config/unicorn.rb":
        ensure  => present,
        /* source => "${gitlab_home}/gitlab/config/unicorn.rb.example", */
        content => template('gitlab/unicorn.rb.erb'),
        owner   => $gitlab_user,
        group   => $gitlab_user,
        require => Vcsrepo[$gitlab_src];  
    "${$gitlab_src}/config/database.yml":
        ensure  => present,
        content => template('gitlab/database.yml.erb'), 
        owner   => $gitlab_user,
        group   => $gitlab_user,
        replace => "false",
        require => Vcsrepo[$gitlab_src];          
     "${gitlab_home}/gitlab-satellites":
        ensure => directory,
        owner   => $gitlab_user,
        group   => $gitlab_user;
      "/etc/init.d/gitlab":
        ensure => present,
        replace => "false",
        content => template("precise-gitlab/gitlab.init.erb"),
        mode => 0744;
      "/var/lib/gitlab/":
        ensure => directory,
        owner => $gitlab_user,
        group => $gitlab_user;
      "/home/$git_user/.gitolite/hooks/common/post-receive":
        source => "$gitlab_src/lib/hooks/post-receive",
        owner => $git_user,
        group => $git_group,
        require => Vcsrepo ["$gitlab_src"],
  }
  
  package { 
	["libicu-dev","libmysqlclient-dev","rake"]:
	  provider => apt;
	["unicorn","resque","sidekiq"]:
	  provider => gem;
   "charlock_holmes":
	  provider => gem,
	  require => Package["libicu-dev"],
	  ensure => "0.6.9";
	"bundler":
	  provider => gem,
	  ensure => installed,
	  require => Package["rake"];
	 "omniauth-twitter":
	  provider => gem,
	  ensure => "0.0.14";
	 "libpq-dev":
	   provider => apt,
	   ensure => present;
    "activerecord-mysql2-adapter":
	   provider => gem,
	   require => Package["libmysqlclient-dev"]
  }

  exec {
	  "git config user":
	   command => 'git config --global user.name GitLab',
	   path => "/bin:/usr/bin:/usr/local/bin",
	   cwd => $gitlab_home,
	   environment => "HOME=$gitlab_home",
	   logoutput => "true",
	   user => $gitlab_user;
	 "git config email":
	   command => 'git config --global user.email "gitlab@localhost"',
	   path => "/bin:/usr/bin:/usr/local/bin",
	   cwd => $gitlab_home,
	   environment => "HOME=$gitlab_home",
	   user => $gitlab_user;
	  "Install gitlab":
	    command => "bundle install --deployment --without development test postgres",
	    cwd => $gitlab_src,
	    path => "/bin:/usr/bin:/usr/local/bin",
	    user => $gitlab_user,
	    group => $gitlab_group,
	    logoutput => "true",
	    creates => "$gitlab_src/vendor/bundle",
	    require => [Package["bundler"] , Vcsrepo["$gitlab_src"] ];
	  "Setup gitlab DB":
	   command => "yes yes | bundle exec rake gitlab:setup RAILS_ENV=production ; touch $gitlab_src/config/db.imported.flag",
	   provider    => shell,
	   cwd => "$gitlab_home/gitlab",
	   path => "/bin:/usr/bin:/usr/local/bin",
	   user => $gitlab_user,
	   group => $gitlab_group,
	   logoutput => "true",
	   creates => "$gitlab_src/config/db.imported.flag", 
	   require => [Package["bundler","activerecord-mysql2-adapter"] , 
	               Vcsrepo["$gitlab_src"] , 
	               Exec["Install gitlab"]];
	  "Auth SSH Key":
	    command => "ssh -o StrictHostKeyChecking=no $git_user@localhost",
	    cwd => $gitlab_home,
	    user => $gitlab_user,
	    group => $gitlab_group,
	    path => "/bin:/usr/bin:/usr/local/bin", 
	    creates => "$gitlab_home/.ssh/known_hosts";
  }
  
  service {
    'gitlab':
      ensure  => running,
      require => [Vcsrepo["$gitlab_src"] , Exec["Setup gitlab DB"] ] ,
      enable  => true;
  }

}
