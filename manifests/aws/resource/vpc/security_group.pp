define bsl_infrastructure::aws::resource::vpc::security_group(
  $ensure = 'present',
  $account_id,
  $tenant_id,
  $vpc = 'default',
  $region = 'us-east-1',
  $description = undef,
  $vpc_cidr_block = '0.0.0.0/0',
  $ingress,
  $tags = {},
) {
  # $debug_msg = "bsl_infrastructure::aws::resource::vpc::security_group[$title] not fully implemented, please see TODOs in \
  #   code"
  #
  # notify { "bsl_infrastructure::aws::resource::vpc::security_group[$title]":
  #   message => "## WARNING: ${$debug_msg}",
  # }
  # warning($debug_msg)


  notify { "## vpc::security_group title=${title} name=${name} vpc=${vpc}": }


  $default_tags = {
    'bsl_account_id' => $account_id,
    'vpc_tenant_id'  => $tenant_id,
  }

  validate_hash($tags)
  $all_tags = merge($default_tags, $tags)

  ec2_securitygroup { $title:
    ensure      => $ensure,
    name        => $name,
    region      => $region,
    description => $description,
    ingress     => $ingress,
    vpc         => $vpc,
    tags        => $all_tags,
  }
}
