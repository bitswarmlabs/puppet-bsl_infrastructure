class bsl_infrastructure::aws::cli {
  notify { '#### here we are in bsl_infrastructure::aws::cli': }

  # contain '::python'
  include '::awscli'

  anchor { 'bsl_infrastructure::aws::cli::begin': }
  # ->Class['::python::install']
  ->Class['::awscli']
  ->anchor { 'bsl_infrastructure::aws::cli::end': }

  # awscli::profile { 'default':
  #   aws_access_key_id     => 'MYAWSACCESSKEYID',
  #   aws_secret_access_key => 'MYAWSSECRETACESSKEY'
  # }
}