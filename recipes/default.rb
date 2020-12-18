#
# Cookbook:: MattRay
# Recipe:: default
#

if debian_platform?
  include_recipe 'mattray::_debian'
elsif raspbian_platform?
  include_recipe 'mattray::_raspbian'
elsif arch_platform?
  include_recipe 'mattray::_arch'
elsif redhat_based?('rhel')
  include_recipe 'mattray::_rhel'
elsif macos_platform?
  include_recipe 'mattray::macos'
end

unless platform_family?('windows')

  # self-signed cert for internal A2 testing
  chef_client_trusted_certificate 'roberto_bottlebru_sh.crt' do
    certificate <<~CERT
-----BEGIN CERTIFICATE-----
MIIDpTCCAo2gAwIBAgIQDFuiRHrz1tFz9SuSv67roDANBgkqhkiG9w0BAQsFADBc
MQswCQYDVQQGEwJVUzEWMBQGA1UEChMNQ2hlZiBTb2Z0d2FyZTEWMBQGA1UECxMN
Q2hlZiBBdXRvbWF0ZTEdMBsGA1UEAxMUcm9iZXJ0by5ib3R0bGVicnUuc2gwHhcN
MjAwNjE1MDUwNDI4WhcNMzAwNjEzMDUwNDI4WjBcMQswCQYDVQQGEwJVUzEWMBQG
A1UEChMNQ2hlZiBTb2Z0d2FyZTEWMBQGA1UECxMNQ2hlZiBBdXRvbWF0ZTEdMBsG
A1UEAxMUcm9iZXJ0by5ib3R0bGVicnUuc2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDKVdEfjE4/89qVqfWYSbGPz+zyGKp/+gPeLGGbA2MknWci7LXT
89SxYspRmJY0/WmdDBZ/r1UNboycFPMWGtYtuqjL5wzQIRQB8Al5t8FB95ScpZSm
b/eR2uuSPXbbwosbbIp2atRRVSHUQQAY8twfYKXtzT0ezss5QWeZvD9PXoTXQ8g+
OobzCghIXcbZ6L2dz/TCU/lrnnC2CiEuIqMgrumre0mBg7F/Zn312BPTbFT94ale
Ai5YXh/2Y+DKfwo36LP/XEm1E/Sxe26KqURD3KTx7yea90iI2KaTVw45HPy5iEsA
gVdcYjGxRDlCGlf1/LGq/CFBxbnm26MDukwHAgMBAAGjYzBhMA4GA1UdDwEB/wQE
AwICpDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDwYDVR0TAQH/BAUw
AwEB/zAfBgNVHREEGDAWghRyb2JlcnRvLmJvdHRsZWJydS5zaDANBgkqhkiG9w0B
AQsFAAOCAQEAIXPYRAVxW9l062tL4Jt+zspjcmj2pZlaS0QN2pxuupRPG3vcvwse
LP0bJAE6qtysNEBl48G6kzIZKE98qug2BCI4PZ9Q/Cr6BQpHOYYsbQsQPmQmRpyM
tEsAl3Owe17Ejl7lK3/yzEOS/p6+yU9A1Un6kVlrKSyDzezxTN/s6J+bGx/efzsA
bL+Zd8QupRNDTUsF8gkme3EZB0cyum4RqBnh72yAiwbHqlGnCAbSf08LKSqTryAW
wwfULOmNroEyQ47AgtW9+g3duLTmC7iSFsCOP+LZtwArBh/VBbmVqWU/iw1kv0aM
+pAx0QNYuA0x5OzMD6wLVO+i2rZ1gmCiRg==
-----END CERTIFICATE-----
CERT
  end

  # self-signed cert for internal Chef Infra Server
  chef_client_trusted_certificate 'ndnd_bottlebru_sh.crt' do
    certificate <<~CERT
-----BEGIN CERTIFICATE-----
MIIEEjCCAvqgAwIBAgIVAONdaqFsLfH6I17wfLpyIOD3iiwXMA0GCSqGSIb3DQEB
CwUAMFAxCzAJBgNVBAYTAlVTMRAwDgYDVQQKDAdZb3VDb3JwMRMwEQYDVQQLDApP
cGVyYXRpb25zMRowGAYDVQQDDBFuZG5kLmJvdHRsZWJydS5zaDAeFw0yMDAyMTQw
NTEzMjZaFw0zMDAyMTEwNTEzMjZaMFAxCzAJBgNVBAYTAlVTMRAwDgYDVQQKDAdZ
b3VDb3JwMRMwEQYDVQQLDApPcGVyYXRpb25zMRowGAYDVQQDDBFuZG5kLmJvdHRs
ZWJydS5zaDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALC3gcmV0js2
OGwH/uA6vY6tgoc56SA7T79O8wIJCIqiO0Mw6A3Qg9ASFj0n2e9jvul393cDhK0y
AETwBm2z4Uvx+e/aQdZpmdG1wc3lCuZ+xtQGjXwaahVIEl5cINS/8bU4Ruu9oFSD
vWxfMEtksvHYP2d7PVbyBG+lhKajaJzuB1ucfM2EiFi+zAlh90b2LX21DVTEEl+6
wWH1MMRLqJnix0b1fCqX6bdDVVKwn7oqvbEVYi1iwk61ltmIUgM2elbfuZ7SQTkg
WH0ar3jdX+SfY5PEfJxxjZTaENNB256GxkqR65a9uY9uiGBTo6Qyb/k4AvLitpuJ
DS2w60ImeJ8CAwEAAaOB4jCB3zAcBgNVHREEFTATghFuZG5kLmJvdHRsZWJydS5z
aDAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBRZei6idyE/nCTIs31VgejxWLJ1
7zCBjgYDVR0jBIGGMIGDgBRZei6idyE/nCTIs31VgejxWLJ176FUpFIwUDELMAkG
A1UEBhMCVVMxEDAOBgNVBAoMB1lvdUNvcnAxEzARBgNVBAsMCk9wZXJhdGlvbnMx
GjAYBgNVBAMMEW5kbmQuYm90dGxlYnJ1LnNoghUA411qoWwt8fojXvB8unIg4PeK
LBcwDQYJKoZIhvcNAQELBQADggEBAClRnvOkg+HwJPsHPOIH3IcWo+X6Xi0umadP
rmNEHQCkZbJMe3K5BRYxoifZgZ7cbTzGsn9N/aH+/SjlH9FVdj53LuqDSS7KyfQ6
yE/MX96/oRt7HAQqZJprLAk903J9h6ojb68e2YgiYPLTNtTh3cDpScKn5t/rbWdX
6SvWdtM/cNDfHfxBzGhBIoVyDlfSbamYDbzwH1JXG8kCsdnZ+28lLW5HN1/lw9lT
505ghcWZENYM/0IQCw7p1yP5OwcyuBVb3BGYptoZt6rZUW65n5KbiKT2/szqREAx
QxHYjlzV3WVG3fEy92GBYQF/nsVdyHx2LkFkNLgeUslJ/BKBECg=
-----END CERTIFICATE-----
CERT
  end

  append_if_no_line 'add ndnd to /etc/hosts' do
    path '/etc/hosts'
    line '10.0.0.2        ndnd ndnd.bottlebru.sh'
  end

  append_if_no_line 'add roberto to /etc/hosts' do
    path '/etc/hosts'
    line '10.0.0.10       roberto roberto.bottlebru.sh'
  end

  unless macos_platform?

    append_if_no_line 'set the PAGER for remote TRAMP sessions' do
      path '/etc/bash.bashrc'
      line 'export PAGER=cat'
    end

    user 'mattray' do
      comment 'Matt Ray'
      manage_home true
      shell '/bin/bash'
      password '$1$nzR3m/Xd$jJ3XxhiFZwuIxJXgqmUXF1'
    end

    directory '/home/mattray/.ssh' do
      owner 'mattray'
      group 'mattray'
      mode '0700'
    end

    cookbook_file '/home/mattray/.ssh/authorized_keys' do
      sensitive true
      source 'authorized_keys'
      mode '0600'
      owner 'mattray'
      group 'mattray'
    end

    sudo 'mattray' do
      user 'mattray'
      nopasswd true
    end

    # this works for Chef and Cinc
    chef_client_systemd_timer 'Run Chef Infra Client as a systemd timer'
  end

end

timezone 'Australia/Sydney'
