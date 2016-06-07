class bsl_infrastructure::provider::aws(
  $ensure = 'present',
  $account_id = hiera('bsl_account_id', $::bsl_account_id),
  $tenant_id = hiera('vpc_tenant_id', $::vpc_tenant_id),
  $internal_domain = hiera('domain', $::domain),
  $services = {},
  $zones = {},
  $vpcs = {},
  $default = 'false',
  $puppetmaster = hiera('puppetmaster', 'puppet'),
) {
  # notify { '#### hello from bsl_infrastructure::provider::aws': }

  $defaults = {
    ensure          => $ensure,
    account_id      => $account_id,
    tenant_id       => $tenant_id,
    internal_domain => $internal_domain,
    services        => $services,
    zones           => $zones,
  }

  if !empty($vpcs) {
    create_resources('bsl_infrastructure::aws::resource::vpc', $vpcs, $defaults)
  }

  $zone_defaults = {
    ensure => 'present',
  }

  if !empty($zones) {
    create_resources('bsl_infrastructure::aws::resource::route53::zones', $zones, $zone_defaults)
  }
}
