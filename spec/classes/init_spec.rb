require 'spec_helper'
describe 'firewalld2iptables' do
  on_supported_os.each do |os, facts|
    context "on #{os} with defaults" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('firewalld2iptables') }

      it { is_expected.to contain_package('iptables-services') \
      .with(ensure: 'present') }

      it { is_expected.to contain_service('firewalld') \
      .with(:ensure => 'stopped', :enable => false,) }

      it { is_expected.to contain_service('iptables') \
      .with(:ensure => 'running', :enable => true,) }

      it { is_expected.to contain_service('ip6tables') \
      .with(:ensure => 'running', :enable => true,) }
    end

    context "on #{os} with all iptables disabled" do
      let(:pre_condition) { 'class { "::firewalld2iptables": 
        iptables_enable => false, 
        ip6tables_enable => false }'
      }
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('firewalld2iptables') }

      it { is_expected.to contain_package('iptables-services') \
      .with(ensure: 'present') }

      it { is_expected.to contain_service('firewalld') \
      .with(:ensure => 'stopped', :enable => false,) }

      it { is_expected.to contain_service('iptables') \
      .with(:ensure => 'stopped', :enable => false,) }

      it { is_expected.to contain_service('ip6tables') \
      .with(:ensure => 'stopped', :enable => false,) }
    end
  end
end