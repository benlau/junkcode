
/*
class puppet-module-prerequisites {

	file { "/etc/puppet/modules":
		ensure => directory,
	}

	package {"puppet-module":
		provider => gem,
		ensure => present,
	}
}
*/

define puppet-module($supplier,$package)  {
	
	$s = $supplier
	$p = $package

#	include puppet-module-prerequisites

	exec { "puppet-module-$package":
		command => "puppet-module install $s/$p",
		path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/opt/vagrant_ruby/bin",
		creates => "/etc/puppet/modules/$p",
		cwd => "/etc/puppet/modules",
		#require => [Package["puppet-module"] , File["/etc/puppet/modules"] ] ,
		#require => Class["puppet-module-prerequisites"],
	}
}
