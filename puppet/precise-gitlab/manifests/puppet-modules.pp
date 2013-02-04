
/* Setup all required puppet-modules
 */

class precise-gitlab::puppet-modules {
	
	if defined(Package["rubygems"]) != true {
		package { rubygems:
			provider => apt,
		}
	}
	
    package { ["puppet"]:
		provider => gem,
		ensure => "2.7.19",
		/*ensure => latest, */
		require => Package[rubygems]
		
		# Problem 1 - puppet-mysql do not work with puppet 2.7.19
		#
		# The Error message:
		# err: /Stage[main]/Mysql::Server/Service[mysqld]: Could not evaluate: undefined method `each' 
		
		# Problem 2 - puppet-module 0.3.4 also do not work with puppet 3.0.2...
		#
		# The Error message:
		# in `block in convert': Error converting value for param 'config': Could not find value for $confdir (Puppet::Settings::InterpolationError)
		#
		 
		# Conclusion:
		# Using puppet 2.7.19 for puppet-module installation. Then 
		# upgrade to 3.x afterword.
    }

	file { "/etc/puppet/modules":
		ensure => directory,
	}

	package { ["puppet-module"]:
		provider => gem,
		ensure => present,
		require => [Package[rubygems] , File["/etc/puppet/modules"]]
    }
	
	puppet-module { "puppet-mysql" :
		supplier => "puppetlabs",
		package => "mysql",
		require => Package["puppet-module","puppet"]
	}

	puppet-module { "puppet-stdlib" :
		supplier => "puppetlabs",
		package => "stdlib",
		require => Package["puppet-module","puppet"]
	}

	puppet-module { "puppet-vcsrepo" :
		supplier => "puppetlabs",
		package => "vcsrepo",
		require => Package["puppet-module","puppet"]
	}
	
	/* For getting templates and some utilities */
    puppet-module { "puppet-gitlab":
		supplier => "sbadia",
		package => "gitlab",
		require => Package["puppet-module"]
	}

}
