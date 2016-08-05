define bsl_infrastructure::provider::aws::vpc_subnet(
  $ensure = 'present',
  $region,
  $vpc = undef,
  $cidr_block = undef,
  $availability_zone = undef,
  $tags = undef,
  $route_table = undef,
  $routes = undef,
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

  ec2_vpc_subnet { $title:
    ensure            => $ensure,
    name              => $name,
    region            => $region,
    cidr_block        => $cidr_block,
    availability_zone => $availability_zone,
    tags              => $set_tags,
    route_table       => $route_table,
    # docuented parameter not imeplemented? routes => $routes,
  }
}
