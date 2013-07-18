# Class: nginx::package::redhat
#
# This module manages NGINX package installation on RedHat based systems
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class nginx::package::redhat {
  $redhat_packages = ['nginx', 'gd', 'libXpm', 'libxslt']

  if downcase($::operatingsystem) == 'redhat' {
    $os_type = 'rhel'
  } else {
    $os_type = downcase($::operatingsystem)
  }

  if $::lsbmajdistrelease == undef {
    $os_rel = regsubst($::operatingsystemrelease, '\..*$', '')
  } else {
    $os_rel = $::lsbmajdistrelease
  }

  yumrepo { "ctlt-release":
    baseurl  => "http://yum.ctlt.ubc.ca/packages/${os_type}/${os_rel}/\$basearch/",
    descr    => 'ctlt repo',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey => "http://nginx.org/keys/nginx_signing.key",
  }

  package { $redhat_packages:
    ensure  => present,
    require => Yumrepo['ctlt-release'],
  }
}
