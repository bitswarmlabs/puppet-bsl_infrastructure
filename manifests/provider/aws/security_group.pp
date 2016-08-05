define bsl_infrastructure::provider::aws::security_group(
  $ensure = 'present',
  $region,
  $description,
  $ingress = undef,
  $tags = undef,
  $vpc = undef,
) {
  if $ingress {
    validate_array($ingress)
  }

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

  if $vpc {
    $vpc_name = Ec2_vpc[$vpc]['name']
  }

  ec2_securitygroup { $title:
    name        => $name,
    region      => $region,
    description => $description,
    ingress     => $ingress,
    tags        => $set_tags,
    vpc         => $vpc_name,
  }

  if $vpc {
    Ec2_vpc[$vpc]->Ec2_securitygroup[$title]
  }
}
