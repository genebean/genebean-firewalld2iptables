# == Class: firewalld2iptables
#
# This module manages firewalld and iptables
#
# === Parameters:
#
# $manage_package::        Installs the iptables-services package when true,
#                          which is the default value.
#                          type: boolean
#
# $iptables_ensure::       This value is passed to the ensure key of the
#                          resource. This should be 'present' or 'latest'.
#                          The default value is 'present'.
#
# $iptables_enable::       Determines if iptables is enabled.
#                          Defaults to true.
#                          type: boolean
#
# $ip6tables_enable::      Determines if ip6tables is enabled.
#                          Defaults to true.
#                          type: boolean
#
# === Usage:
# * Simple usage:
#
#     include ::firewalld2iptables
#
# * Manage the iptables-services package elsewhere
#
#     class { '::firewalld2iptables': $manage_package => false, }
#
#
class firewalld2iptables (
  $manage_package   = true,
  $iptables_ensure  = 'present',
  $iptables_enable  = true,
  $ip6tables_enable = true
) {

  # Only run on systems known to have firewalld
  case $::osfamily {
    'RedHat' : {
      if ($::operatingsystemmajrelease == '7') {
        if ($manage_package) {
          package { 'iptables-services': ensure => $iptables_ensure, }
        }
        
        service { 'firewalld':
          ensure  => 'stopped',
          enable  => false,
          require => Package['iptables-services'],
          before  => [
            Service['iptables'],
            Service['ip6tables']
          ],
        }
      
        if ($iptables_enable) {
          service { 'iptables':
            ensure  => 'running',
            enable  => true,
            require => Service['firewalld'],
          }
        } else {
          service { 'iptables':
            ensure => 'stopped',
            enable => false,
          }
        } # end $iptables_enable
      
        if ($ip6tables_enable) {
          service { 'ip6tables':
            ensure  => 'running',
            enable  => true,
            require => Service['firewalld'],
          }
        } else {
          service { 'ip6tables':
            ensure => 'stopped',
            enable => false,
          }
        } # end $ip6tables_enable
      }
      
    } # end RedHat
    
    default: {
    }
    
  } # end case $::osfamily
}
