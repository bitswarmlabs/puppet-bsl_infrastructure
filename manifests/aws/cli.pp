class bsl_infrastructure::aws::cli(
  $version = 'latest',
) {
  include '::python'

  package { 'awscli':
    ensure   => $version,
    provider => 'pip',
  }

  # awscli::profile { 'default':
  #   aws_access_key_id     => 'MYAWSACCESSKEYID',
  #   aws_secret_access_key => 'MYAWSSECRETACESSKEY'
  # }
}