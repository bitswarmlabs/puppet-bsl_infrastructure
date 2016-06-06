class bsl_infrastructure::debug(
  $ensure = 'present',
) {
  notify { "## hello from bsl_infrastructure.debug": }

  ec2_vpc { 'sample-vpc':
    ensure       => $ensure,
    region       => 'us-east-1',
    cidr_block   => '172.30.0.0/16',
  }

  ec2_vpc_subnet { 'sample-subnet':
    ensure            => $ensure,
    region            => 'us-east-1',
    vpc               => 'sample-vpc',
    cidr_block        => '172.30.0.0/24',
    availability_zone => 'us-east-1b',
    route_table       => 'sample-routes',
  }

  ec2_vpc_internet_gateway { 'sample-igw':
    ensure => $ensure,
    region => 'us-east-1',
    vpc    => 'sample-vpc',
  }

  ec2_vpc_routetable { 'sample-routes':
    ensure => $ensure,
    region => 'us-east-1',
    vpc    => 'sample-vpc',
    routes => [
      {
        destination_cidr_block => '0.0.0.0/0',
        gateway                => 'sample-igw'
      },
      # {
      #   destination_cidr_block => '172.30.0.0/16',
      #   gateway                => 'local'
      # },
    ],
  }

  if $ensure == absent {
    Ec2_vpc_internet_gateway['sample-igw']~>
    Ec2_vpc_subnet['sample-subnet']~>
    Ec2_vpc_routetable['sample-routes']~>
    Ec2_vpc['sample-vpc']
    # ~>
    # Ec2_vpc_dhcp_options['sample-options']
  }
}
