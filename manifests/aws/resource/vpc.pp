define bsl_infrastructure::aws::resource::vpc(
  $ensure = 'present',
  $account_id = hiera('bsl_account_id', $::bsl_account_id),
  $tenant_id = hiera('bsl_tenant_id', $::bsl_tenant_id),
  $region = 'us-east-1',
  $cidr_block = '10.0.0.0/16',
  $instance_tenancy = undef,
  $tags = { },

  $manage_dhcp_options = 'true',
  $dhcp_options_name = $name,
  $internal_domain = hiera('domain', $::domain),
  $domain_name_servers = ['AmazonProvidedDNS'],
  $ntp_servers = undef,

  $manage_subnets = 'true',
  $subnets = [],

  $manage_gateway = 'true',
  $gateway_name = $name,

  $manage_route_table = 'true',
  $route_table_name = $name,

  $services = { },
  $zones = { },

  $security_groups = { },
) {
  include 'bsl_infrastructure::aws'

  $debug_msg = "bsl_infrastructure::aws::resource::vpc[$title] not fully implemented, please see TODOs in code"
  notify { "bsl_infrastructure::aws::resource::vpc[$title]":
    message => "## WARNING: ${debug_msg}",
  }
  warning($debug_msg)

  $default_tags = {
    'bsl_account_id' => $account_id,
    'vpc_tenant_id'  => $tenant_id,
  }

  validate_hash($tags)
  $all_tags = merge($default_tags, $tags)

  ec2_vpc { $name:
    ensure           => $ensure,
    region           => $region,
    cidr_block       => $cidr_block,
    dhcp_options     => $dhcp_options_name,
    instance_tenancy => $instance_tenancy,
    tags             => $all_tags,
  }

  if str2bool($manage_dhcp_options) {
    ec2_vpc_dhcp_options { $dhcp_options_name:
      ensure              => $ensure,
      tags                => $all_tags,
      region              => $region,
      netbios_node_type   => 2,
      # domain_name         => $internal_domain,
      domain_name_servers => $domain_name_servers,
      ntp_servers         => $ntp_servers,
    }
  }

  if str2bool($manage_subnets) and !empty($subnets) {
    $subnet_defaults = {
      ensure           => $ensure,
      account_id       => $account_id,
      tenant_id        => $tenant_id,
      vpc              => $name,
      region           => $region,
      tags             => $all_tags,
      route_table_name => $route_table_name,
      internal_domain  => $internal_domain,
      vpc_cidr_block   => $cidr_block,
    }

    create_resources('bsl_infrastructure::aws::resource::vpc::subnet', $subnets, $subnet_defaults)
  }

  if str2bool($manage_gateway) {
    ec2_vpc_internet_gateway { $gateway_name:
      ensure => $ensure,
      region => $region,
      vpc    => $name,
      tags   => $all_tags,
    }
  }

  if str2bool($manage_route_table) {
    ec2_vpc_routetable { $route_table_name:
      ensure => $ensure,
      region => $region,
      vpc    => $name,
      tags   => $all_tags,
      # routes => [
      #   {
      #     destination_cidr_block => $cidr_block,
      #     gateway                => 'local'
      #   },
      #   {
      #     destination_cidr_block => '0.0.0.0/0',
      #     gateway                => $gateway_name,
      #   },
      # ],
    }
  }

  if !empty($security_groups) {
    $sg_defaults = {
      ensure           => $ensure,
      account_id       => $account_id,
      tenant_id        => $tenant_id,
      vpc              => $name,
      region           => $region,
      vpc_cidr_block   => $cidr_block,
    }

    create_resources('bsl_infrastructure::aws::resource::vpc::security_group', $security_groups, $sg_defaults)
  }

  if $ensure == absent {
    Ec2_vpc_internet_gateway[$gateway_name]
    ~> Ec2_vpc_subnet<| vpc == $name |>
    ~> Ec2_vpc_routetable<| vpc == $name |>
    ~> Ec2_vpc[$name]
    ~> Ec2_vpc_dhcp_options[$dhcp_options_name]
  }
}
