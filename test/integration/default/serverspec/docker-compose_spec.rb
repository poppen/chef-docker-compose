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

describe file('/etc/docker-compose.d/base.yml') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_grouped_into 'root' }

  it { is_expected.to contain('base') }
  it { is_expected.to contain("'8022:22'").after('base') }
  it { is_expected.not_to contain("!ruby/hash:Chef::Node::ImmutableMash") }
end
