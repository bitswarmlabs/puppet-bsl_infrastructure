define bsl_infrastructure::provider(
  $purge = 'false',
  $provider = $name,
  $default = 'false',
  $account_id = hiera('bsl_account_id', $::bsl_account_id),
  $tenant_id = hiera('bsl_tenant_id', $::bsl_tenant_id),
  $internal_domain = hiera('domain', $::domain),
  $puppetmaster = hiera('puppetmaster', 'puppet'),
  $config = [],
) {
  if str2bool($purge) {
    $_ensure = 'absent'
  }
  else {
    $_ensure = 'present'
  }

  validate_string($account_id)

  if ! defined(Bsl_account::Verify[$account_id]) {
    bsl_account::verify { $account_id: }
  }

  $defaults = {
    'default'         => 'false',
    'account_id'      => $account_id,
    'internal_domain' => $internal_domain,
    'ensure'          => $_ensure,
    'require'         => Bsl_account::Verify[$account_id],
  }

  if defined("bsl_infrastructure::provider::$provider") {
    create_resources("bsl_infrastructure::provider::$provider", $config, $defaults)
  }
  else {
    fail("unknown provider: $provider")
  }
}
