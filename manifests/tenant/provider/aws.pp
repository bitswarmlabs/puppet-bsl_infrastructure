class bsl_infrastructure::tenant::provider::aws(
  $purge = 'false',
  $bsl_account_id,
  $vpc_tenant_id,
  $internal_domain = $::domain,
  $services = undef,
  $zones = undef,
  $vpcs = undef,
) {
  assert_private("bsl_infrastructure::tenant::provider::aws is private and cannot be invoked directly")

  include 'bsl_infrastructure::provider::aws::sdk'

  if $vpcs {
    validate_hash($vpcs)

    $vpc_defaults = {
      purge           => $purge,
      bsl_account_id  => $bsl_account_id,
      vpc_tenant_id   => $vpc_tenant_id,
      internal_domain => $internal_domain,
      services        => $services,
      zones           => $zones,
      require         => Class['bsl_infrastructure::provider::aws::sdk'],
    }

    create_resources('bsl_infrastructure::resource::aws::vpc', $vpcs, $vpc_defaults)
  }

  if $zones {
    validate_hash($zones)

    $zone_defaults = {
      require         => Class['bsl_infrastructure::provider::aws::sdk'],
    }

    create_resources('bsl_infrastructure::resource::aws::zone', $zones, $zone_defaults)
  }

  if $services {
    validate_hash($services)

    $service_defaults = {
      purge           => $purge,
      bsl_account_id  => $bsl_account_id,
      vpc_tenant_id   => $vpc_tenant_id,
      require         => Class['bsl_infrastructure::provider::aws::sdk'],
    }

    create_resources('bsl_infrastructure::resource::aws::service', $services, $service_defaults)
  }
}
