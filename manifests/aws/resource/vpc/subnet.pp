define bsl_infrastructure::aws::resource::vpc::subnet(
  $ensure = 'present',
  $account_id = $::bsl_account_id,
  $vpc = undef,
  $gateway = undef,
  $region = 'us-east-1',
  $availability_zone = 'us-east-1a',
  $cidr_block = '10.0.0.0/16',
  $vpc_cidr_block = '10.0.0.0/16',
  $tags = undef,
  $route_table_name = $name,
  $internal_domain = 'bitswarm.internal',
) {
  ec2_vpc_subnet { $name:
    ensure            => $ensure,
    region            => $region,
    vpc               => $vpc,
    cidr_block        => $cidr_block,
    availability_zone => $availability_zone,
    route_table       => $route_table_name,
  }

  ec2_vpc_routetable { $route_table_name:
    ensure => $ensure,
    region => $region,
    vpc    => $vpc,
    routes => [
      {
        destination_cidr_block => $vpc_cidr_block,
        gateway                => 'local'
      },
      {
        destination_cidr_block => '0.0.0.0/0',
        gateway                => $gateway,
      },
    ],
  }
}
