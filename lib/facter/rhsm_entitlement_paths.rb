require 'facter'

Dir.glob('/etc/pki/entitlement/*.pem') { |f|
    if f =~ /-key.pem/
        Facter.add('rhsm_key_path') do
            setcode do
                f
            end
        end
    else
        Facter.add('rhsm_cert_path') do
            setcode do
                f
            end
        end
    end
}

