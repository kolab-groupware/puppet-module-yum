class yum::standard inherits yum::client {
    case $os {
        "Fedora": {
            repository { [
                    "release",
                    "updates",
                    "rpmfusion-free",
                    "rpmfusion-free-updates",
                    "rpmfusion-nonfree",
                    "rpmfusion-nonfree-updates"
                ]:
                enable => true,
                gpgkey => true;
                [
                    "updates-testing",
                    "rpmfusion-free-updates-testing",
                    "rpmfusion-nonfree-updates-testing",
                    "development",
                    "rpmfusion-free-development",
                    "rpmfusion-nonfree-development"
                ]:
                enable => false,
                gpgkey => true;
                [
                    "koji"
                ]:
                enable => false,
                gpgkey => false
            }
            case $osmajorver {
                "8", "9": {
                    repository {
                        [ "updates-newkey" ]:
                            enable => true;
                        [ "updates-testing-newkey" ]:
                            enable => false
                    }
                }
            }
        }
        "CentOS": {
            case $osmajorver {
                "4": {
                    repository { [
                            "release",
                            "updates",
                            "epel"
                        ]:
                        enable => true,
                        gpgkey => true;
                        [
                            "epel-testing",
                            "addons",
                            "extras",
                            "plus"
                        ]:
                        enable => false
                    }
                }
                "5": {
                    repository { [
                            "release",
                            "updates",
                            "epel",
                            "rpmfusion-free",
                            "rpmfusion-free-updates",
                            "rpmfusion-nonfree",
                            "rpmfusion-nonfree-updates"
                        ]:
                        enable => true;
                        [
                            "epel-testing",
                            "addons",
                            "extras",
                            "plus",
                            "rpmfusion-free-updates-testing",
                            "rpmfusion-nonfree-updates-testing"
                        ]:
                        enable => false
                    }
                }
                "6": {
                    repository { [
                            "release",
                            "updates",
                            "epel"
                        ]:
                        enable => true;
                        [
                            "rpmfusion-free",
                            "rpmfusion-nonfree",
                            "rpmfusion-free-updates",
                            "rpmfusion-nonfree-updates"
                        ]:
                        gpgkey => true,
                        enable => true;
                        [
                            "epel-testing",
                            "addons",
                            "extras",
                            "plus",
                            "rpmfusion-free-updates-testing",
                            "rpmfusion-nonfree-updates-testing"
                        ]:
                        enable => false
                    }
                }
            }
        }
        "RedHat": {
            case $osmajorver {
                "4": {
                    repository { [
                            "epel"
                        ]:
                        enable => true;
                        [
                            "epel-testing"
                        ]:
                        enable => false
                    }
                }
                "5": {
                    repository { [
                            "epel",
                            "rpmfusion-free",
                            "rpmfusion-free-updates",
                            "rpmfusion-nonfree",
                            "rpmfusion-nonfree-updates"
                        ]:
                        enable => true;
                        [
                            "epel-testing",
                            "rpmfusion-free-updates-testing",
                            "rpmfusion-nonfree-updates-testing"
                        ]:
                        enable => false
                    }
                }
                "6": {
                    repository { [
                            "epel",
                        ]:
                        enable => true;
                        [
                            "rpmfusion-free",
                            "rpmfusion-nonfree",
                            "rpmfusion-free-updates",
                            "rpmfusion-nonfree-updates"
                        ]:
                        gpgkey => true,
                        enable => true;
                        [
                            "epel-testing",
                            "rpmfusion-free-updates-testing",
                            "rpmfusion-nonfree-updates-testing"
                        ]:
                        enable => false
                    }
                }
            }
        }
    }
}
