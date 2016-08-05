# bsl_infrastructure::resource::aws::service::instance
# ========================================================
#
# Convenience wrapper for managing EC2 instanes
#
# Parameters
# ----------
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Authors
# -------
#
# Reuben Avery <ravery@bitswarm.io>
#
define bsl_infrastructure::resource::aws::service::instance(
  # Required
  $ensure = 'running',
  $region,
  $bsl_account_id,
  $vpc_tenant_id,
  $image_id = undef,
  $instance_type = 't1.micro',
  $puppet_environment = $::environment,

  # Optional
  $security_groups = undef,
  $tags = undef,
  $tenancy = undef,
  $user_data_template = 'bsl_infrastructure/ec2/user-data.erb',

  # Optional and settable only at creation:
  $user_data = undef,
  $key_name = undef,
  $monitoring = undef,
  $availability_zone = undef,
  $private_ip_address = undef,
  $associate_public_ip_address = undef,
  $subnet = undef,
  $ebs_optimized = undef,
  $instance_initiated_shutdown_behavior = undef,
  $block_devices = undef,
  $iam_instance_profile_name = undef,
  $iam_instance_profile_arn = undef,

  # abstractions
  $elastic_ip = undef,
  $elastic_ip_ensure = 'attached',
) {
  $instance_title = "${vpc_tenant_id}_${name}"

  anchor { "bsl_infrastructure::resource::aws::service::instance[$title]::begin": }

  validate_re($ensure, ['^present','^absent','^running','^stopped'])
  validate_re($region, ['^us\-east\-1', '^us\-west\-1'])

  if $tenancy {
    validate_re($tenancy, ['^default', '^dedicated'])
  }

  if $private_ip_address {
    validate_ipv4_address($private_ip_address)
  }

  if $associate_public_ip_address {
    validate_re($associate_public_ip_address, ['^true', '^false'])
  }

  if $ebs_optimized {
    validate_re($ebs_optimized, ['^true', '^false'])
  }

  if $instance_initiated_shutdown_behavior {
    validate_re($instance_initiated_shutdown_behavior, ['^stop', '^terminate'])
  }

  if $block_devices {
    validate_array($block_devices)
  }

  if $image_id {
    $set_image_id = $image_id
  }
  else {
    $set_image_id = $region ? {
      'us-east-1' => 'ami-c8800bdf',
      'us-west-1' => 'ami-be88cfde',
    }
  }

  if $user_data {
    $set_user_data = $user_data
  }
  elsif $user_data_template {
    $set_user_data = template($user_data_template)
  }

  $default_tags = {
    'bsl_account_id' => $bsl_account_id,
    'vpc_tenant_id'  => $vpc_tenant_id,
    'puppet_managed' => 'true',
  }

  if $tags {
    validate_hash($tags)
    $set_tags = merge($tags, $default_tags)
  }
  else {
    $set_tags = $default_tags
  }

  Anchor["bsl_infrastructure::resource::aws::service::instance[$title]::begin"]
  ->
  ec2_instance { $instance_title:
    name                                 => $name,
    ensure                               => $ensure,
    region                               => $region,
    image_id                             => $set_image_id,
    instance_type                        => $instance_type,
    security_groups                      => $security_groups,
    tags                                 => $set_tags,
    # no parameter defined? -- tenancy => $tenancy,
    user_data                            => $set_user_data,
    key_name                             => $key_name,
    monitoring                           => $monitoring,
    availability_zone                    => $availability_zone,
    private_ip_address                   => $private_ip_address,
    associate_public_ip_address          => $associate_public_ip_address,
    subnet                               => $subnet,
    ebs_optimized                        => $ebs_optimized,
    instance_initiated_shutdown_behavior => $instance_initiated_shutdown_behavior,
    block_devices                        => $block_devices,
    iam_instance_profile_name            => $iam_instance_profile_name,
    iam_instance_profile_arn             => $iam_instance_profile_arn,
  }

  if $subnet {
    Ec2_vpc_subnet[$subnet]
    ->Ec2_instance[$instance_title]
  }

  if $security_groups {
    Ec2_securitygroup[$security_groups]
    ->Ec2_instance[$instance_title]
  }

  # read only properties:
  #
  # instance_id
  # hypervisor
  # virtualization_type
  # public_ip_address
  # private_dns_name
  # public_dns_name
  # kernel_id

  if $elastic_ip {
    ec2_elastic_ip { $elastic_ip:
      region   => $region,
      instance => $name,
      ensure   => $elastic_ip_ensure,
    }
  }

  Ec2_instance[$instance_title]~>
  anchor { "bsl_infrastructure::resource::aws::service::instance[$title]::end": }
}
