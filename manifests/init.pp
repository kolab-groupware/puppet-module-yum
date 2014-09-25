class yum {
    # The redhat-lsb package needs to be installed to provide lsbdist variables
    package { "redhat-lsb":
        ensure => installed
    }
}
