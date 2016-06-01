class bsl_infrastructure::aws::cli(
  $version = 'latest',
) {
  notify { '#### here we are in bsl_infrastructure::aws::cli': }

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