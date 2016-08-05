define bsl_infrastructure::provider::aws::vpc(
  $ensure = 'present',
  $region,
  $cidr_block,
  $dhcp_options = undef,
  $instance_tenancy = undef,
  $tags = undef,
  $subnets = undef,
) {
  $default_tags = {
    'puppet_managed' => 'true',
  }

  if $tags {
    validate_hash($tags)
    $set_tags = merge($tags, $default_tags)
  }
  else {
    $set_tags = $default_tags
  }

  ec2_vpc { $title:
    ensure       => $ensure,
    name         => $name,
    region       => $region,
    cidr_block   => $cidr_block,
    dhcp_options => $dhcp_options,
    tags         => $set_tags,
  }

  if $subnets {
    validate_hash($subnets)

    $vpc_subnet_defaults = {
      vpc     => $name,
      ensure  => $ensure,
      region  => $region,
      require => Ec2_vpc[$title],
    }

    create_resources('bsl_infrastructure::provider::aws::vpc_subnet', $subnets, $vpc_subnet_defaults)
  }
}
