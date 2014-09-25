define yum::repository ($enable = true, $gpgkey = false) {

    # A list of expired repositories per os, osver and name
    #
    # livna still carries 1 package: libdvdcss, and so
    # it doesn't make sense to disable it yet on F-10
    #
    # Keep this snippet here nonetheless because it might
    # be usefull in the future
    #
    #$expired = false

    $expired = $os ? {
        "Fedora" => $osmajorver ? {
            "11" => $name ? {
                "livna" => true,
                "livna-testing" => true,
                "livna-development" => true,
                default => false
            },
            "12" => $name ? {
                "livna" => true,
                "livna-testing" => true,
                "livna-development" => true,
                default => false
            },
            "13" => $name ? {
                "livna" => true,
                "livna-testing" => true,
                "livna-development" => true,
                default => false
            },
            "14" => $name ? {
                "livna" => true,
                "livna-testing" => true,
                "livna-development" => true,
                default => false
            },
            "15" => $name ? {
                "livna" => true,
                "livna-testing" => true,
                "livna-development" => true,
                default => false
            },
            default => false
        },
        default => false
    }

    case $name {
        "epel", "epel-testing": {
            if defined(Package["epel-release"]) {
                realize(Package["epel-release"])
            } else {
                @package { "epel-release":
                    ensure => latest
                }
                realize(Package["epel-release"])
            }
        }

        "release", "updates", "development": {
            case $os {
                "Fedora": {
                    if defined(Package["fedora-release"]) {
                        realize(Package["fedora-release"])
                    } else {
                        @package { "fedora-release":
                            ensure => latest
                        }
                        realize(Package["fedora-release"])
                    }
                }
                "CentOS": {
                    if defined(Package["centos-release"]) {
                        realize(Package["centos-release"])
                    } else {
                        @package { "centos-release":
                            ensure => latest
                        }
                        realize(Package["centos-release"])
                    }
                }
                "RedHat": {
                    if defined(Package["redhat-release"]) {
                        realize(Package["redhat-release"])
                    } else {
                        @package { "redhat-release":
                            ensure => latest
                        }
                        realize(Package["redhat-release"])
                    }
                }
            }
        }

        "rpmfusion-free", "rpmfusion-free-updates": {
            case $os {
                "CentOS", "RedHat": {
                }
                default: {
                    if defined(Package["rpmfusion-free-release"]) {
                        realize(Package["rpmfusion-free-release"])
                    } else {
                        @package { "rpmfusion-free-release":
                            ensure => latest
                        }
                        realize(Package["rpmfusion-free-release"])
                    }
                }
            }
        }

        "rpmfusion-nonfree", "rpmfusion-nonfree-updates": {
            if defined(Package["rpmfusion-nonfree-release"]) {
                realize(Package["rpmfusion-nonfree-release"])
            } else {
                @package { "rpmfusion-nonfree-release":
                    ensure => latest
                }
                realize(Package["rpmfusion-nonfree-release"])
            }
        }
    }

    file { "/etc/yum/repos.d/$name.repo":
        ensure => $expired ? {
            true => absent,
            default => file
        },
        mode => "644",
        owner => "root",
        group => "root",
        backup => false,
        links => follow,
        source => $enable ? {
            true => [
                "puppet://$server/private/$environment/yum/$os/$osver/repos/$name.repo.$hostname",
                "puppet://$server/private/$environment/yum/$os/$osver/repos/$name.repo",
                "puppet://$server/private/$environment/yum/$os/$osmajorver/repos/$name.repo.$hostname",
                "puppet://$server/private/$environment/yum/$os/$osmajorver/repos/$name.repo",
                "puppet://$server/private/$environment/yum/repos/$os/$name.repo.$hostname",
                "puppet://$server/private/$environment/yum/repos/$os/$name.repo",
                "puppet://$server/modules/files/yum/$os/$osver/repos/$name.repo.$hostname",
                "puppet://$server/modules/files/yum/$os/$osver/repos/$name.repo",
                "puppet://$server/modules/files/yum/$os/$osmajorver/repos/$name.repo.$hostname",
                "puppet://$server/modules/files/yum/$os/$osmajorver/repos/$name.repo",
                "puppet://$server/modules/yum/$os/$osver/repos/$name.repo",
                "puppet://$server/modules/yum/$os/$osmajorver/repos/$name.repo"
            ],
            default => [
                "puppet://$server/private/$environment/yum/$os/$osver/repos/$name.repo.disabled.$hostname",
                "puppet://$server/private/$environment/yum/$os/$osver/repos/$name.repo.disabled",
                "puppet://$server/private/$environment/yum/$os/$osmajorver/repos/$name.repo.disabled.$hostname",
                "puppet://$server/private/$environment/yum/$os/$osmajorver/repos/$name.repo.disabled",
                "puppet://$server/private/$environment/yum/repos/$os/$name.repo.disabled.$hostname",
                "puppet://$server/private/$environment/yum/repos/$os/$name.repo.disabled",
                "puppet://$server/modules/files/yum/$os/$osver/repos/$name.repo.disabled.$hostname",
                "puppet://$server/modules/files/yum/$os/$osver/repos/$name.repo.disabled",
                "puppet://$server/modules/files/yum/$os/$osmajorver/repos/$name.repo.disabled.$hostname",
                "puppet://$server/modules/files/yum/$os/$osmajorver/repos/$name.repo.disabled",
                "puppet://$server/modules/yum/$os/$osver/repos/$name.repo.disabled",
                "puppet://$server/modules/yum/$os/$osmajorver/repos/$name.repo.disabled"
            ]
        },
        require => Package["redhat-lsb"]
    }

    case $gpgkey {
        false: {
        }
        true: {
            # Distribute the GPG-KEY files along with the repository
            if (!defined(File["/etc/pki/rpm-gpg/RPM-GPG-KEY-$name"])) {
                file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-$name":
                    ensure => $expired ? {
                        true => absent,
                        default => file
                    },
                    mode => "644",
                    owner => "root",
                    group => "root",
                    backup => false,
                    links => follow,
                    source => [
                        "puppet://$server/private/$environment/yum/$os/$osver/gpgkeys/RPM-GPG-KEY-$name",
                        "puppet://$server/private/$environment/yum/$os/$osmajorver/gpgkeys/RPM-GPG-KEY-$name",
                        "puppet://$server/private/$environment/yum/gpgkeys/$os/RPM-GPG-KEY-$name",
                        "puppet://$server/modules/files/yum/$os/$osver/gpgkeys/RPM-GPG-KEY-$name",
                        "puppet://$server/modules/files/yum/$os/$osmajorver/gpgkeys/RPM-GPG-KEY-$name",
                        "puppet://$server/modules/yum/$os/$osver/gpgkeys/RPM-GPG-KEY-$name",
                        "puppet://$server/modules/yum/$os/$osmajorver/gpgkeys/RPM-GPG-KEY-$name"
                    ],
                    noop => false,
                    notify => Exec["import_gpg_key_$name"]
                }
            }

            if (!defined(Exec["import_gpg_key_$name"])) {
                exec { "import_gpg_key_$name":
                    command => "/bin/rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-$name",
                    refreshonly => true,
                    noop => false
                }
            }
        }
        default: {
            if (!defined(File["/etc/pki/rpm-gpg/$gpgkey"])) {
                file { "/etc/pki/rpm-gpg/$gpgkey":
                    ensure => $expired ? {
                        true => absent,
                        default => file
                    },
                    mode => "644",
                    owner => "root",
                    group => "root",
                    backup => false,
                    links => follow,
                    source => [
                        "puppet://$server/private/$environment/yum/$os/$osver/gpgkeys/$gpgkey",
                        "puppet://$server/private/$environment/yum/$os/$osmajorver/gpgkeys/$gpgkey",
                        "puppet://$server/private/$environment/yum/gpgkeys/$os/$gpgkey",
                        "puppet://$server/modules/files/yum/$os/$osver/gpgkeys/$gpgkey",
                        "puppet://$server/modules/files/yum/$os/$osmajorver/gpgkeys/$gpgkey",
                        "puppet://$server/modules/yum/$os/$osver/gpgkeys/$gpgkey",
                        "puppet://$server/modules/yum/$os/$osmajorver/gpgkeys/$gpgkey"
                    ],
                    noop => false,
                    notify => Exec["import_gpg_key_$gpgkey"]
                }
            }

            if (!defined(Exec["import_gpg_key_$gpgkey"])) {
                exec { "import_gpg_key_$gpgkey":
                    command => "/bin/rpm --import /etc/pki/rpm-gpg/$gpgkey",
                    refreshonly => true,
                    noop => false
                }
            }
        }
    }
}
