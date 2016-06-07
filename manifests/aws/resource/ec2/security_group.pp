define bsl_infrastructure::aws::resource::ec2::security_group() {
  # $debug_msg = "bsl_infrastructure::aws::resource::ec2::security_group[$title] not fully implemented, please see TODOs in \
  #   code"
  #
  # notify { "bsl_infrastructure::aws::resource::ec2::security_group[$title]":
  #   message => "## WARNING: ${$debug_msg}",
  # }
  # warning($debug_msg)

  include 'bsl_infrastructure::aws::resource::ec2'

  anchor { "bsl_infrastructure::aws::resource::ec2::security_group::${title}::begin": }

  Bsl_infrastructure::Aws::Resource::Vpc::Security_group[$name]~>Anchor["bsl_infrastructure::aws::resource::ec2::security_group::${title}::begin"]
}
