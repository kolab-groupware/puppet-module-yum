class yum::client inherits yum {
    # We want everything in /etc/yum/
    # This is the location yum looks at (/etc/yum.conf is a fallback)
    # Also, we want to prevent *-release packages from installing
    # files in the directory used as reposdir.

    file { "/etc/yum.conf":
        ensure => "/etc/yum/yum.conf",
        require => File["/etc/yum/yum.conf"],
        links => manage
    }

    # This space is managed by RPM
    # We don't want to use it to make it clear we ship our own repos
    file { "/etc/yum.repos.d/":
        ensure => absent,
        force => true
    }

    file { "/etc/yum/":
        ensure => directory,
        owner => "root",
        group => "root",
        purge => true,
        mode => "755"
    }

    # this is where yum actually looks first
    file { "/etc/yum/repos.d/":
        ensure => directory,
        owner => "root",
        group => "root",
        mode => "755",
        purge => true,
        force => true,
        require => File["/etc/yum/"]
    }

    file { "/etc/yum/yum.conf":
        owner => "root",
        group => "root",
        mode => "644",
        source => [
            "puppet://$server/private/$environment/yum/yum.conf.$hostname",
            "puppet://$server/private/$environment/yum/yum.conf",
            "puppet://$server/modules/files/yum/yum.conf.$hostname",
            "puppet://$server/modules/files/yum/yum.conf",
            "puppet://$server/modules/yum/yum.conf"
        ],
        require => File["/etc/yum/"]
    }

    case $os {
        "RedHat": {
            file { "/etc/yum/repos.d/rhel-6-server-rpms.repo":
                content => template("yum/rhel-6-server-rpms.repo.erb"),
                noop => false
            }

            file { "/etc/yum/repos.d/rhel-6-server-optional-rpms.repo":
                content => template("yum/rhel-6-server-optional-rpms.repo.erb"),
                noop => false
            }

            # Purge the stock configuration files to avoid duplicate
            # definitions.
            file { "/etc/yum/repos.d/redhat.repo":
                ensure => absent,
                noop => false
            }

            file { "/etc/yum/repos.d/rhel-source.repo":
                ensure => absent,
                noop => false
            }

            if (!defined(File["/etc/rhsm/rhsm.conf"])) {
                file { "/etc/rhsm/rhsm.conf":
                    mode => "644",
                    owner => "root",
                    group => "root",
                    source => [
                            "puppet://$server/private/$environment/yum/rhsm.conf.$hostname",
                            "puppet://$server/private/$environment/yum/rhsm.conf",
                            "puppet://$server/files/yum/rhsm.conf.$hostname",
                            "puppet://$server/files/yum/rhsm.conf",
                            "puppet://$server/modules/yum/rhsm.conf"
                        ],
                    noop => false
                }
            }
        }
    }
}

