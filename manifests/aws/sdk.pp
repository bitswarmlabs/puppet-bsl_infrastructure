class bsl_infrastructure::aws::sdk(
  $aws_sdk_gem_version = latest, # '2.2.37', '2.3.11'
  $retries_gem_version = present,
) {
  # notify { '#### here we are in bsl_infrastructure::aws::sdk': }

  # If we're on Amazon we've got the ruby sdk in an rpm. Otherwise we'll get
  # it via gems.
  if $::operatingsystem == 'Amazon' {
    package { 'rubygem-aws-sdk':
      ensure => latest,
      notify => Service['puppetmaster'],
      # ensure => '1.26.0-1.0.amzn1',
    }

  }
  else {
    include '::ruby'

    package { 'aws-sdk':
      ensure   => $aws_sdk_gem_version,
      provider => 'puppet_gem',
      notify   => Service['puppetserver'],
    }

    package { 'retries':
      ensure   => $retries_gem_version,
      provider => 'puppet_gem',
    }

    # package { 'nokogiri':
    #   ensure   => '1.5.6',
    #   provider => 'gem',
    # } ->
    # package { 'json':
    #   ensure   => '1.4.6',
    #   provider => 'gem',
    # } ->
    # package { 'uuidtools':
    #   ensure   => '2.1.1',
    #   provider => 'gem',
    # } ->
    # package { 'aws-sdk':
    #   ensure   => ['1.26.0'],
    #   provider => 'gem',
    # }
  }
}
