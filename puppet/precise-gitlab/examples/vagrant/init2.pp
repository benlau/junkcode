
/* Initialize step 2 - Install all required puppet-module.

  p.s Puppet 2.7.19 is required.
 */

class {
	"precise-gitlab::puppet-modules":
}

