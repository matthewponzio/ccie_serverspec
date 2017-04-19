require_relative 'spec_helper'

describe 'Checking directories' do
  describe file('/var/lib/replicated/circle-config') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_mode '755' }
  end
end

describe 'Checking ports are listening' do
  %w(80 443 8800 9874 9875 9876 9877 9878).each do |p|
    describe port(p) do
      it { should be_listening.with('tcp6') }
    end
  end
end
    
