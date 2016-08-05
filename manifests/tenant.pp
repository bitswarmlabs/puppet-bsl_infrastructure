define bsl_infrastructure::tenant(
  $purge = 'false',
  $bsl_account_id = $name,
  $vpc_tenant_id = $name,
  $internal_domain = hiera('domain', $::domain),
  $puppetmaster = hiera('puppetmaster', 'puppet'),
  $providers = undef,
) {
  include 'bsl_infrastructure::auth'

  # bsl_account::verify { $name:
  #   account_id => $bsl_account_id,
  #   tenant_id  => $vpc_tenant_id,
  # }

  if $providers {
    validate_hash($providers)

    $defaults = {
      purge           => false,
      bsl_account_id  => $bsl_account_id,
      vpc_tenant_id   => $vpc_tenant_id,
      internal_domain => $internal_domain,
    }

    create_resources('bsl_infrastructure::tenant::provider', $providers, $defaults)
  }
}
