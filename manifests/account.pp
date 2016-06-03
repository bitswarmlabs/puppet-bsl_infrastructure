define bsl_infrastructure::account(
  $account_id = $::bsl_account_id,
  $internal_domain = $::domain,
  $providers = [],
) {
  $defaults = {
    account_id => $account_id,
    internal_domain => $internal_domain,
  }

  create_resources('bsl_infrastructure::provider', $providers, $defaults)
}
