class yum::testing inherits yum::client {
    case $os {
        "Fedora": {
            repository { [
                    "release",
                    "updates",
                    "updates-testing",
                    "livna",
                    "rpmfusion-free",
                    "rpmfusion-free-updates",
                    "rpmfusion-nonfree",
                    "rpmfusion-nonfree-updates"
                ]:
                enable => true;
                [
                    "development",
                    "rpmfusion-free-development",
                    "rpmfusion-nonfree-development",
                    "rpmfusion-free-updates-testing",
                    "rpmfusion-nonfree-updates-testing",
                    "koji"
                ]:
                    enable => false
            }
            case $osmajorver {
                "8", "9": {
                    repository {
                        [ "updates-newkey", "updates-testing-newkey" ]:
                            enable => true
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
                            "epel",
                            "epel-testing"
                        ]:
                        enable => true;
                        [
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
                "6": {
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
            }
        }
        "RedHat": {
            case $osmajorver {
                "4": {
                    repository { [
                            "epel",
                            "epel-testing"
                        ]:
                        enable => true
                    }
                }
                "5": {
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
                "6": {
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
    }
}

