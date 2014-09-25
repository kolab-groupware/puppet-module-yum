class yum::eatbabies inherits yum::client {
    case $os {
        "Fedora": {
            repository { [
                    "development",
                    "livna",
                    "rpmfusion-free-development",
                    "rpmfusion-nonfree-development",
                    "koji"
                ]:
                enable => true;
                [
                    "release",
                    "updates",
                    "updates-testing",
                    "rpmfusion-free",
                    "rpmfusion-free-updates",
                    "rpmfusion-free-updates-testing",
                    "rpmfusion-nonfree",
                    "rpmfusion-nonfree-updates",
                    "rpmfusion-nonfree-updates-testing"
                ]:
                enable => false
            }
            case $osmajorver {
                "8", "9": {
                    repository {
                        [ "updates-newkey", "updates-testing-newkey" ]:
                            enable => false
                    }
                }
            }
        }
        "CentOS": {
            repository { [
                    "release",
                    "updates",
                    "epel",
                    "epel-testing",
                    "rpmfusion-free",
                    "rpmfusion-free-updates",
                    "rpmfusion-nonfree",
                    "rpmfusion-nonfree-updates"
                ]:
                enable => true;
                [
                    "rpmfusion-free-updates-testing",
                    "rpmfusion-nonfree-updates-testing",
                    "addons",
                    "extras",
                    "plus"
                ]:
                enable => false
            }
        }
        "RedHat": {
            repository { [
                    "epel",
                    "epel-testing",
                    "rpmfusion-free",
                    "rpmfusion-free-updates",
                    "rpmfusion-nonfree",
                    "rpmfusion-nonfree-updates"
                ]:
                enable => true;
                [
                    "rpmfusion-free-updates-testing",
                    "rpmfusion-nonfree-updates-testing"
                ]:
                enable => false
            }
        }
    }
}
