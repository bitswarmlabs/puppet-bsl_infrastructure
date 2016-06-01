define bsl_infrastructure::aws::vpc(
  $ensure = 'present',
  $cidr_block = '10.108.0.0/16',
  $subnets = [
    "${}"
  ],
  $primary_subnet_name = 'us-east-1b.bitswarm.internal',
  $primary_subnet_cidr_block = '10.108.0.0/24',
  $route_table_name = 'bitswarm',
  $gateway_name = 'bitswarm.internal',

  $region = 'us-east-1',
  $availability_zone = 'us-east-1b',
) {
  include 'bsl_infrastructure::aws'

  ec2_vpc { $vpc_name:
    ensure       => $ensure,
    region       => $region,
    cidr_block   => $vpc_cidr_block,
  }

  # ec2_securitygroup { 'sample-sg':
  #   ensure      => present,
  #   region      => 'sa-east-1',
  #   vpc         => 'sample-vpc',
  #   description => 'Security group for VPC',
  #   ingress     => [{
  #     security_group => 'sample-sg',
  #   },{
  #     protocol => 'tcp',
  #     port     => 22,
  #     cidr     => '0.0.0.0/0'
  #   }]
  # }

  ec2_vpc_subnet { $name:
    ensure            => $ensure,
    region            => $region,
    vpc               => $vpc_name,
    cidr_block        => $primary_subnet_cidr_block,
    availability_zone => $availability_zone,
    route_table       => $route_table_name,
  }

  ec2_vpc_routetable { $route_table_name:
    ensure => $ensure,
    region => $region,
    vpc    => $vpc_name,
    routes => [
      {
        destination_cidr_block => $vpc_cidr_block,
        gateway                => 'local'
      },
      {
        destination_cidr_block => '0.0.0.0/0',
        gateway                => $gateway_name,
      },
    ],
  }

  ec2_vpc_internet_gateway { $gateway_name:
    ensure => $ensure,
    region => $region,
    vpc    => $vpc_name,
  }

  ec2_vpc_dhcp_options { 'bitswarm.internal':
    region => $region,
  }

}