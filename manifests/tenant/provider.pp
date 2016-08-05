define bsl_infrastructure::tenant::provider(
  $purge = 'false',
  $bsl_account_id,
  $vpc_tenant_id,
  $internal_domain = $::domain,
  $config = undef,
) {
  include 'bsl_infrastructure::auth'

  if defined("bsl_infrastructure::tenant::provider::${name}") {
    if $config {
      validate_hash($config)

      class { "bsl_infrastructure::tenant::provider::${name}":
        purge             => $purge,
        bsl_account_id    => $bsl_account_id,
        vpc_tenant_id     => $vpc_tenant_id,
        internal_domain   => $internal_domain,
        services          => $config['services'],
        zones             => $config['zones'],
        vpcs              => $config['vpcs'],
        require           => Bsl_infrastructure::Provider[$name],
      }
    }
  }
  else {
    fail("unknown provider: ${name}")
  }
}
