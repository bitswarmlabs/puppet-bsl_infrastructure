class bsl_infrastructure::aws::config(
  $domain = $bsl_core::aws::params::domain,
  $region = $bsl_core::aws::params::region,
  $availability_zone = $bsl_core::aws::params::availability_zone,

  $vpc_name = $bsl_core::aws::params::vpc_name,
  $primary_subnet_name = $bsl_core::aws::params::primary_subnet_name,
  $route_table_name = $bsl_core::aws::params::route_table_name,
  $gateway_name = $bsl_core::aws::params::gateway_name,

  $vpc_cidr_block = '10.108.0.0/16',
  $primary_subnet_cidr_block = '10.108.0.0/24',
) inherits bsl_infrastructure::aws::params {
  notify { 'bsl_infrastructure::aws::config debug':
    message => template('bsl_infrastructure/config_debug_message.erb'),
  }
}