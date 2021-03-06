# Class: rails
# ===========================
#
# Add Ruby and Ruby on Rails using rbenv.
#
# Parameters
# ----------
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `ruby_version`
# The version of Ruby that rbenv will install.
#
# * `rails_version`
# The version of Rails that rbenv will install.

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
  # Install Rbenv on the system to manage the system's Ruby version.
  class { 'rbenv': latest => true } # Install rbenv

  # Rbenv plugins.
  rbenv::plugin { [ 'rbenv/rbenv-vars', 'rbenv/ruby-build' ]: 
    latest => true
  }

  # Build the defined Ruby version.
  rbenv::build { $ruby_version : global => true }

  ## Gems ##
  # Install system wide gems via rbenv.

  # r10k Gem
  rbenv::gem { 'r10k':
    ruby_version => $ruby_version,
    skip_docs    => true,
  }
  # Rails Gem
  rbenv::gem { 'rails':
    ruby_version => $ruby_version,
    skip_docs    => true,
    version      => $rails_version,
  }

  ## Database Backaend ##
  # Uncomment the desired database backends
  # TODO Use a parameter to select the db engine.

  # MySQL & Rails
  #$rails_mysql = [ 'mysql-server', 'mysql-client', 'libmysqlclient-dev' ]
  #package { $rails_mysql :
  #  ensure => present
  #}

  # Postgresql & Rails
  #package { 'postgresql-common': ensure => present }
  #package { 'postgresql-9.5', 'libpq-dev': ensure => present }

  # SQLite3 & Rails
  package { [ 'sqlite3', 'libsqlite3-dev' ]:
    ensure => present 
  }
}
