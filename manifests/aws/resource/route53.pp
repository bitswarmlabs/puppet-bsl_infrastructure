class bsl_infrastructure::aws::resource::route53(
  $ensure = 'present',
  $zones = {},
) {
  validate_hash($zones)

  $defaults = {
    ensure => $ensure,
  }

  if !empty($zones) {
    create_resources('bsl_infrastructure::aws::resource::route53::zones', $zones, $defaults)
  }
}
