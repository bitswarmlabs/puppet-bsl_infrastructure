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
  notify { "## hello from bsl_infrastructure::provider for account=$account_id tenant=$tenant_id": }

  if str2bool($purge) {
    $_ensure = 'absent'
  }
  else {
    $_ensure = 'present'
  }

  validate_string($account_id)
  validate_string($provider)
  validate_hash($config)

  if empty($tenant_id) {
    $_tenant_id = $account_id
  }
  else {
    $_tenant_id = $tenant_id
  }

  if ! defined(Bsl_account::Verify[$account_id]) {
    bsl_account::verify { $_tenant_id:
      account_id => $account_id,
    }
  }

  $defaults = {
    'default'         => 'false',
    'account_id'      => $account_id,
    'tenant_id'       => $tenant_id,
    'internal_domain' => $internal_domain,
    'puppetmaster'    => $puppetmaster,
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
