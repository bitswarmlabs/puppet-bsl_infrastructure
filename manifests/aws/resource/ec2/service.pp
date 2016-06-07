define bsl_infrastructure::aws::resource::ec2::service(
  $ensure = 'present',
  $account_id,
  $tenant_id,
  $ami,
  $type = 't1.micro',
  $iam_profile_name = undef,
  $iam_profile_arn = undef,
  $security_groups = { },
  $role = undef,
  $profile = undef,
  $environment = undef,
  $comment = undef,
  $tags = { },

  $private_ip = 'default',
  $public_ip = 'default',
  $elastic_ip = undef,
  $vpc = 'default',
  $region = 'us-east-1',
  $availability_zone = 'us-east-1a',
  $subnet = undef,
  $ebs_optimized = 'false',
  $monitoring = 'false',
  $shutdown_behavior = 'stop',
  $block_devices = [
    {
      device_name  => '/dev/sda1',
      volume_size  => 8,
    }
  ],
  $key_name = undef,
  $user_data_template = 'bsl_infrastructure/ec2/user-data.erb',
) {
  # $debug_msg = "bsl_infrastructure::aws::resource::ec2::service[$title] not fully implemented, please see TODOs in \
  #   code"
  #
  # notify { "bsl_infrastructure::aws::resource::ec2::service[$title]":
  #   message => "## WARNING: ${$debug_msg}",
  # }
  # warning($debug_msg)

  include 'bsl_infrastructure::aws::resource::ec2'

  if empty($subnet) {
    $_region = $region
    $_availability_zone = $availability_zone
  }
  else {
    $_region = $region
    $_availability_zone = undef
  }

  if !empty($private_ip) and $private_ip != 'default' {
    $private_ip_address = $private_ip
    validate_ip_address($private_ip)
  }

  if !empty($key_name) {
    $key_pair_name = $key_name
    bsl_infrastructure::aws::resource::ec2::key{ $key_name: }~>
    Ec2_instance[$name]
  }
  else {
    $key_pair_name = $bsl_infrastructure::aws::resource::ec2::ec2_default_key_pair_name
  }

  $default_tags = {
    # 'bsl_account_id' => $account_id,
    # 'vpc_tenant_id'  => $tenant_id,
    'environment'    => $environment,
    'role'           => $role,
    'profile'        => $profile,
    'comment'        => $comment,
  }

  validate_hash($tags)
  $all_tags = merge($default_tags, $tags)

  validate_re($shutdown_behavior, '(stop|terminate)')

  ec2_instance { $name:
    ensure                               => $ensure,
    region                               => $_region,
    availability_zone                    => $_availability_zone,
    subnet                               => $subnet,
    image_id                             => $ami,
    instance_type                        => $type,
    private_ip_address                   => $private_ip_address,
    associate_public_ip_address          => $public_ip,
    ebs_optimized                        => str2bool($ebs_optimized),
    monitoring                           => str2bool($monitoring),
    instance_initiated_shutdown_behavior => $shutdown_behavior,
    block_devices                        => $block_devices,
    key_name                             => $key_pair_name,
    security_groups                      => $security_groups,
    iam_instance_profile_name            => $iam_profile_name,
    iam_instance_profile_arn             => $iam_profile_arn,
    user_data                            => template($user_data_template),
    tags                                 => $all_tags,
  }

  $readonly_vars = [
    instance_id,
    hypervisor,
    virtualization_type,
    public_ip_address,
    private_dns_name,
    public_dns_name,
    kernel_id,
  ]

  if !empty($security_groups) {
    create_resources('bsl_infrastructure::aws::resource::ec2::security_group', $security_groups)
  }
}
