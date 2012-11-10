$debs = ["rubygems","psmisc"]

/* In this test, it need a node.js module called nodeload. It 
 * can be installed by npm. But puppet do not support npm
 * by default. It have to install the puppet-module 
 * through gem first. Therefore, the installation is divided
 * into 2 phases. The phase 1 install puppet module and the 
 * phase 2 install nodeload.
 */

package { $debs :
    provider => apt,
    ensure => latest,
}

package {"puppet-module":
    provider => gem,
    require => Package[$debs]
}

exec { "puppet-module install puppetlabs/nodejs":
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    creates => "/etc/puppet/modules/nodejs",
    cwd => "/etc/puppet/modules",
    require => Package["puppet-module"]
}




