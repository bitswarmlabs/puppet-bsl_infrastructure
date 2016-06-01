class bsl_infrastructure::aws {
  class { '::ec2tagfacts': }
  class { 'bsl_infrastructure::aws::sdk': }
}
