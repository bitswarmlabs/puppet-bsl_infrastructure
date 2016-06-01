class bsl_infrastructure::aws {
  include '::python'
  include 'bsl_infrastructure::aws::sdk'

  Class['::python']->
  class { '::ec2tagfacts':
    
  }

}
