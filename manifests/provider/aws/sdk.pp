class bsl_infrastructure::provider::aws::sdk(
  $aws_sdk_gem_version = present,
  $retries_gem_version = present,
) {
  assert_private("bsl_infrastructure::provider::aws::sdk is private and cannot be invoked directly")

  # If we're on Amazon we've got the ruby sdk in an rpm. Otherwise we'll get
  # it via gems.
  if $::operatingsystem == 'Amazon' {
    package { 'rubygem-aws-sdk':
      ensure => '1.26.0-1.0.amzn1',
    }
  }
  else {
    include '::ruby'

    package { 'aws-sdk':
      ensure   => $aws_sdk_gem_version,
      provider => 'puppet_gem',
    }

    package { 'retries':
      ensure   => $retries_gem_version,
      provider => 'puppet_gem',
    }
  }
}
