define bsl_infrastructure::tenant(
  $account_id = $::bsl_account_id,
  $internal_domain = $::domain,
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
