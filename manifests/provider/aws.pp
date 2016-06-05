class bsl_infrastructure::provider::aws(
  $ensure = 'present',
  $account_id = hiera('bsl_account_id', $::bsl_account_id),
  $tenant_id = hiera('bsl_tenant_id', $::bsl_tenant_id),
  $internal_domain = hiera('domain', $::domain),
  $puppetmaster = hiera('puppetmaster', 'puppet'),
  $images = [],
  $regions = [],
  $vpcs = [],
  $security_groups = [],
  $instances = [],
  $default = 'false',
) {
  # notify { '#### hello from bsl_infrastructure::provider::aws': }

  $defaults = {
    ensure          => $ensure,
    account_id      => $account_id,
    tenant_id       => $tenant_id,
    internal_domain => $internal_domain,
  }

  if !empty($vpcs) {
    create_resources('bsl_infrastructure::aws::resource::vpc', $vpcs, $defaults)
  }
}
