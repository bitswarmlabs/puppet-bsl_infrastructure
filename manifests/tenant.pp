define bsl_infrastructure::tenant(
  $account_id = hiera('bsl_account_id', $::bsl_account_id),
  $tenant_id = hiera('bsl_tenant_id', $::bsl_tenant_id),
  $internal_domain = hiera('domain', $::domain),
  $puppetmaster = hiera('puppetmaster', 'puppet'),
  $providers = [],
) {
  $defaults = {
    account_id => $account_id,
    internal_domain => $internal_domain,
    puppetmaster => $puppetmaster,
  }

  create_resources('bsl_infrastructure::provider', $providers, $defaults)
}
