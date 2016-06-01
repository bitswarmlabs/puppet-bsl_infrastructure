class bsl_infrastructure::aws::cli {
  notify { '#### here we are in bsl_infrastructure::aws::cli': }

  include '::python'

  anchor { 'bsl_infrastructure::aws::cli::begin': }
  ->Class['::python::install']
  ->Package <| title == 'pip' |>
  ->class { '::awscli': }
  ->anchor { 'bsl_infrastructure::aws::cli::end': }

  # awscli::profile { 'default':
  #   aws_access_key_id     => 'MYAWSACCESSKEYID',
  #   aws_secret_access_key => 'MYAWSSECRETACESSKEY'
  # }
}