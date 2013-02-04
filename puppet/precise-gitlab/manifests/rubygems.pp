/* Setup rubygems and ruby 1.9.3 over Ubuntu 12.04 Precise

   The ruby come with Vagrant's precise image is customized
   with own path which is incompatible to many puppet-module.
   
   This class will replace the customized version of Ruby
   and use the ruby 1.9.3 provided by Ubuntu.
   
   Moreover , it will also setup puppet-modules 

 */

class precise-gitlab::rubygems {
	exec{ "ruby193 - apt-get update":
		command => "apt-get update",
       path => "/bin:/usr/bin",
	}
	
	$deb = ["ruby1.9.3","rubygems"]
	
	package { $deb:
		provider => apt,
		require => Exec["ruby193 - apt-get update"]
	}
	
	exec {
		"set ruby 1.9 as default":
			require => Package["ruby1.9.3","rubygems"],
			path => "/bin:/usr/bin:/usr/local/bin",
			command => "update-alternatives --set ruby /usr/bin/ruby1.9.1";
		"set gem 1.9 as default":
			require => Package["ruby1.9.3","rubygems"],
			path => "/bin:/usr/bin:/usr/local/bin",
			command => "update-alternatives --set gem /usr/bin/gem1.9.1";
	}
}

