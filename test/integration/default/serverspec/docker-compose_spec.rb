require 'serverspec'

set :backend, :exec

describe file('/usr/local/bin/docker-compose') do
  it { is_expected.to be_executable }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_grouped_into 'root' }
end

describe file('/etc/docker-compose.d') do
  it { is_expected.to be_directory }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_grouped_into 'root' }
end

describe file('/etc/docker-compose.d/docker-compose.yml') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_grouped_into 'root' }

  it { is_expected.to contain('base') }
end

describe file('/etc/init/docker-compose.conf') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_grouped_into 'root' }
end
