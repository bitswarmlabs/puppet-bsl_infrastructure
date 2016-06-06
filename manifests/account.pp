define bsl_infrastructure::account(
  $account_id = hiera('bsl_account_id', undef),
  $tenant_id = hiera('bsl_tenant_id', undef),
  $type = 'standard',
  $internal_domain = hiera('domain', $::domain),
  $puppetmaster = hiera('puppetmaster', 'puppet'),
  $providers = [],
) {
  validate_string($account_id)
  validate_hash($providers)
  validate_re($type, [ '^standard', '^tenant'])

  bsl_account::verify { $account_id:
    account_id => $account_id,
    tenant_id => $tenant_id,
  }

  $defaults = {
    account_id => $account_id,
    tenant_id => $tenant_id,
    internal_domain => $internal_domain,
    puppetmaster => $puppetmaster,
  }

  create_resources('bsl_infrastructure::provider', $providers, $defaults)
}
