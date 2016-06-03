define bsl_infrastructure::provider::aws(
  $ensure = 'present',
  $account_id = $::bsl_account_id,
  $images = [],
  $regions = [],
  $vpcs = [],
  $default = 'false',
  $internal_domain = $::domain,
) {
  notify { '#### hello from bsl_infrastructure::provider::aws': }

  $defaults = {
    ensure          => $ensure,
    account_id      => $account_id,
    internal_domain => $internal_domain,
  }

  if !empty($vpcs) {
    create_resources('bsl_infrastructure::aws::resource::vpc', $vpcs, $defaults)
  }
}