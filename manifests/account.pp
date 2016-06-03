define bsl_infrastructure::account(
  $account_id = $::bsl_account_id,
  $internal_domain = $::domain,
  $puppetmaster = hiera('puppetmaster', 'puppet'),
  $providers = [],
) {
  $defaults = {
    tenant_id => $account_id,
    internal_domain => $internal_domain,
    puppetmaster => $puppetmaster,
  }

  create_resources('bsl_infrastructure::tenant', $providers, $defaults)
}
