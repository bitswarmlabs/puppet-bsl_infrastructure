define bsl_infrastructure::aws::resource::vpc(
  $ensure = 'present',
  $account_id = hiera('bsl_account_id', $::bsl_account_id),
  $tenant_id = hiera('bsl_tenant_id', $::bsl_tenant_id),
  $region = 'us-east-1',
  $cidr_block = '10.0.0.0/16',
  $instance_tenancy = undef,
  $tags = undef,

  $manage_dhcp_options = 'true',
  $dhcp_options_name = $name,
  $internal_domain = hiera('domain', $::domain),
  $domain_name_servers = ['AmazonProvidedDNS'],
  $ntp_servers = undef,

  $manage_subnets = 'true',
  $subnets = [],

  $manage_gateway = 'true',
  $gateway_name = $name,
) {
  include 'bsl_infrastructure::aws'

  ec2_vpc { $name:
    ensure           => $ensure,
    region           => $region,
    cidr_block       => $cidr_block,
    dhcp_options     => $dhcp_options_name,
    instance_tenancy => $instance_tenancy,
    tags             => $tags,
  }

  if str2bool($manage_dhcp_options) {
    ec2_vpc_dhcp_options { $dhcp_options_name:
      tags                => $tags,
      region              => $region,
      domain_name         => $internal_domain,
      domain_name_servers => $domain_name_servers,
      ntp_servers         => $ntp_servers,
    }
  }

  $defaults = {
    ensure          => $ensure,
    account_id      => $account_id,
    vpc             => $name,
    gateway         => $gateway_name,
    region          => $region,
    tags            => $tags,
    internal_domain => $internal_domain,
    vpc_cidr_block  => $cidr_block,
  }

  if str2bool($manage_subnets) and !empty($subnets) {
    create_resources('bsl_infrastructure::aws::resource::vpc::subnet', $subnets, $defaults)
  }

  if str2bool($manage_gateway) {
    ec2_vpc_internet_gateway { $name:
      ensure => $ensure,
      region => $region,
      vpc    => $name,
      tags   => $tags,
    }
  }

  if $ensure == absent {
    Ec2_vpc_internet_gateway[$name]
    ~> Ec2_vpc_subnet<| |>
    ~> Ec2_vpc_routetable<| |>
    ~> Ec2_vpc[$name]
    ~> Ec2_vpc_dhcp_options[$name]
  }
}
