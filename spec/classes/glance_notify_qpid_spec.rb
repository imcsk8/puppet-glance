require 'spec_helper'
describe 'glance::notify::qpid' do
  let :facts do
    {
      :osfamily => 'Debian'
    }
  end
  let :params do
    {:qpid_password => 'pass'}
  end

  let :pre_condition do
    'class { "glance::api": keystone_password => "pass" }'
  end

  it { should contain_glance_api_config('DEFAULT/notifier_strategy').with_value('qpid') }
  it { should contain_glance_api_config('DEFAULT/qpid_username').with_value('guest') }
  it { should contain_glance_api_config('DEFAULT/qpid_password').with_value('pass') }
  it { should contain_glance_api_config('DEFAULT/qpid_hostname').with_value('localhost') }
  it { should contain_glance_api_config('DEFAULT/qpid_port').with_value('5672') }
  it { should contain_glance_api_config('DEFAULT/qpid_protocol').with_value('tcp') }

  describe 'when passing params' do
    let :params do
      {
        :qpid_password => 'pass',
        :qpid_usernane => 'guest2',
        :qpid_hostname => 'localhost2',
        :qpid_port     => '5673'
      }
      it { should contain_glance_api_config('DEFAULT/qpid_username').with_value('guest2') }
      it { should contain_glance_api_config('DEFAULT/qpid_hostname').with_value('localhost2') }
      it { should contain_glance_api_config('DEFAULT/qpid_port').with_value('5673') }
      it { should contain_glance_api_config('DEFAULT/qpid_protocol').with_value('tcp') }
    end
  end

  describe 'configuring with ssl' do
    let :params do
      {
        :qpid_password => 'pass',
        :qpid_usernane => 'guest2',
        :qpid_host     => 'localhost2',
        :qpid_port     => '5671',
        :qpid_protocol => 'ssl'
      }
      it { should contain_glance_api_config('DEFAULT/qpid_username').with_value('guest2') }
      it { should contain_glance_api_config('DEFAULT/qpid_host').with_value('localhost2') }
      it { should contain_glance_api_config('DEFAULT/qpid_port').with_value('5671') }
      it { should contain_glance_api_config('DEFAULT/qpid_protocol').with_value('ssl') }
    end
  end
end
