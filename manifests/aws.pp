class bsl_infrastructure::aws {
  include '::python'
  include 'bsl_infrastructure::aws::sdk'

  class { '::awscli': }

  # awscli::profile { 'default':
  #   aws_access_key_id     => 'MYAWSACCESSKEYID',
  #   aws_secret_access_key => 'MYAWSSECRETACESSKEY'
  # }
}
