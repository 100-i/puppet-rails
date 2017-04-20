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
class rails {
  # NodeJS
  class { 'nodejs': version => latest }

  # rbenv
  class { 'rbenv': latest => true }

  # rbenv plugins: ruby-build, ruby-vars
  rbenv::plugin { [ 'rbenv/rbenv-vars', 'rbenv/ruby-build' ]: latest => true }

  # Ruby version 2.4.1
  rbenv::build { '2.4.1': global => true }

  # Gems
  rbenv::gem { [ 'rails', 'r10k' ]: ruby_version => '2.4.1' }

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

  #rbenv::gem { 'sqlite3':
  #  ruby_version => '2.4.1'
  #}

}
