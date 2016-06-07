class bsl_infrastructure::aws::params {
  $domain = hiera('domain', $::domain)
  $region = hiera('region', 'us-east-1')
  $availability_zone = hiera('availability_zone', $::ec2_metadata['placement']['availability-zone'])

  $vpc_name = $domain
  $primary_subnet_name = "${availability_zone}.${domain}"
  $route_table_name = $domain
  $gateway_name = $domain

  $vpc_cidr_block = '10.108.0.0/16'
  $primary_subnet_cidr_block = '10.108.0.0/24'

  $ec2_default_key_pair_name = hiera('ec2_default_key_pair_name')
}
