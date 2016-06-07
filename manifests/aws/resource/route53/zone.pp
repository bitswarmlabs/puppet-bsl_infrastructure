define bsl_infrastructure::aws::resource::route53::zone(
  $ensure = 'present',
  $account_id = hiera('bsl_account_id', $::bsl_account_id),
  $tenant_id = hiera('bsl_tenant_id', $::bsl_tenant_id),
  $vpcs = {},
) {
  include 'bsl_infrastructure::aws::resource::route53'

  route53_zone { $name:
    ensure => $ensure,
  }
}
