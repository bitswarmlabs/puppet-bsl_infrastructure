class bsl_infrastructure::aws(
  $internal_domain = $::domain,
  $puppetmaster = hiera('puppetmaster', "puppet.${::domain}"),
) {
  assert_private("${module_name} is private and cannot be invoked directly")
  require 'bsl_infrastructure::auth'
}
