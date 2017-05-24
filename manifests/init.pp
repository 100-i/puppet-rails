# Class: rails
# ===========================
#
# Add Ruby and Ruby on Rails using rbenv.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'rails':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
#  100 Industries <hundred.industries@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017, 100 Industries; unless otherwise noted.
#
class rails (
  $ruby_version  = '2.5.0-dev',
  $rails_version = '5.1.1',
) {
  package { 'autoconf':
    ensure => present,
  }

  package { 'bison':
    ensure => present,
  }

  class { 'nodejs': version => latest } # NodeJS

  ## Rbenv ##
  class { 'rbenv': latest => true } # Install rbenv

  # rbenv plugins
  rbenv::plugin { [ 'rbenv/rbenv-vars', 'rbenv/ruby-build' ]: 
    latest => true
  }

  # Build the defined Ruby version
  rbenv::build { $ruby_version : global => true }

  ## Gems ##
  # Install system wide gems via rbenv.
  #
  # r10k Gem
  rbenv::gem { 'r10k':
    ruby_version => $ruby_version,
    skip_docs    => true,
  }
  # Rails Gem
  rbenv::gem { 'rails':
    ruby_version => $ruby_version,
    skip_docs    => true,
    version      => '5.1.0.rc1',
  }

  ## Yarn ##
  # Install Yarn as a system package.
  package { 'yarn':
    ensure => present,
  }

  # MySQL & Rails
# $rails_mysql = [ 'mysql-server', 'mysql-client', 'libmysqlclient-dev' ]
# package { $rails_mysql :
#   ensure => present
# }

  # Postgresql & Rails
# package { 'postgresql-common': ensure => present }
# package { 'postgresql-9.5', 'libpq-dev': ensure => present }

  # SQLite3 & Rails
  package { [ 'sqlite3', 'libsqlite3-dev' ]:
    ensure => present 
  }
}
