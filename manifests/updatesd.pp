class yum::updatesd {
    package { "yum-updatesd":
        ensure => $os ? {
            "CentOS" => $osmajorver ? {
                4 => absent,
                default => installed
            },
            default => installed
        }
    }

    file { "/etc/yum/yum-updatesd.conf":
        ensure => file,
        owner => root,
        group => root,
        mode => "640",
        source => [
            "puppet://$server/private/$environment/yum/yum-updatesd.conf.$hostname",
            "puppet://$server/private/$environment/yum/yum-updatesd.conf",
            "puppet://$server/modules/files/yum/yum-updatesd.conf.$hostname",
            "puppet://$server/modules/files/yum/yum-updatesd.conf",
            "puppet://$server/modules/yum/yum-updatesd.conf"
        ],
        require => Package["yum-updatesd"],
        notify => Service["yum-updatesd"]
    }

    service { "yum-updatesd":
        ensure => running,
        enable => true,
        require => [
            File["/etc/yum/yum-updatesd.conf"],
            Package["yum-updatesd"]
        ]
    }
}
