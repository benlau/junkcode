
/* Initialize step 1 - Install Ruby 1.9.3 and Rubygems. Override
   the ruby and rubygems provided by vagrant image.
 */

include precise-gitlab::rubygems

package {
	"puppet":
		provider => gem,
		ensure => "2.7.19",
		require => Class["precise-gitlab::rubygems"];
	"puppet-module": 
		ensure => "0.3.4",
		provider => gem,
		require => Class["precise-gitlab::rubygems"];
}

