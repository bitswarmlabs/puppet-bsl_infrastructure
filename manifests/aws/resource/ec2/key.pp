define bsl_infrastructure::aws::resource::ec2::key() {
  $debug_msg = "bsl_infrastructure::aws::resource::ec2::key[$title] not fully implemented, please see TODOs in \
    code"

  notify { "bsl_infrastructure::aws::resource::ec2::key[$title]":
    message => "## WARNING: ${$debug_msg}",
  }
  warning($debug_msg)

  include 'bsl_infrastructure::aws::resource::ec2'

  anchor { "bsl_infrastructure::aws::resource::ec2::key::${title}::begin": }

  # TODO: Need to implement, the aws module does not provide this convenience.

  # Bsl_infrastructure::Aws::Resource::Vpc::key[$name]~>Anchor["bsl_infrastructure::aws::resource::ec2::key::${title}::begin"]
}
