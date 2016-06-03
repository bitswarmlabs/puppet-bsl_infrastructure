define bsl_infrastructure::account(
  $account_id = $::bsl_account_id,
  $internal_domain = $::domain,
  $providers = [],
) {
  $defaults = {
    tenant_id => $account_id,
    internal_domain => $internal_domain,
  }

  create_resources('bsl_infrastructure::tenant', $providers, $defaults)
}
