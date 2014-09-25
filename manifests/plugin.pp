define yum::plugin($enable = false, $confname = false) {
    file { "/etc/yum/pluginconf.d/$name.conf":
        ensure => $enable ? {
            true => file,
            default => absent
        },
        path => $confname ? {
            false => "/etc/yum/pluginconf.d/$name.conf",
            default => "/etc/yum/pluginconf.d/$confname.conf"
        },
        owner => "root",
        group => "root",
        mode => "644",
        source => $confname ? {
            false => [
                "puppet://$server/private/$environment/yum/plugins/$name.conf",
                "puppet://$server/files/yum/plugins/$name.conf",
                "puppet://$server/modules/yum/plugins/$name.conf"
            ],
            default => [
                "puppet://$server/private/$environment/yum/plugins/$confname.conf",
                "puppet://$server/files/yum/plugins/$confname.conf",
                "puppet://$server/modules/yum/plugins/$confname.conf"
            ]
        }
    }

    package { "yum-plugin-$name":
        name => $os ? {
            "CentOS" => "yum-$name",
            "RedHat" => "yum-$name",
            "Fedora" => "yum-plugin-$name",
        },
        ensure => $enable ? {
            true => installed,
            default => absent
        },
        alias => "yum-$name"
    }

    case $name {
        "versionlock": {
            file { "/etc/yum/pluginconf.d/versionlock.list":
                source => [
                    "puppet://$server/private/$environment/yum/plugins/versionlock.list",
                    "puppet://$server/files/yum/plugins/versionlock.list",
                    "puppet://$server/modules/yum/plugins/versionlock.list"
                ]
            }
        }
    }
}
