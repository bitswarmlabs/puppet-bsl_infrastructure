class bsl_infrastructure::aws::cli(
  $version = '1.10.35',
) {
  include '::python'

  package { 'awscli':
    ensure   => $version,
    provider => 'pip',
    install_options => '--upgrade',
  }

  # awscli::profile { 'default':
  #   aws_access_key_id     => 'MYAWSACCESSKEYID',
  #   aws_secret_access_key => 'MYAWSSECRETACESSKEY'
  # }
}
