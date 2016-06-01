class bsl_infrastructure::aws {
  include 'bsl_infrastructure::aws::sdk'

  class { '::ec2tagfacts':
    before => Class['::python'],
  }

}
