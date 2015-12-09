require 'spec_helper'

puts 'Starting IIS container verification tests!'

##### Start Networking verifications #####
# RDP is open...right?  Is IIS listening on port 80?
%w{80 3389}.each do |ports|
  describe port(ports) do
    it { should be_listening.with('tcp') }
  end
end

# We're not listening for unencrypted telnet connections...right?
describe port(23) do
  it { should_not be_listening }
end

# The firewall is up...right?
describe service('MpsSvc') do
  it { should be_running }
end
##### End Networking Verifications #####



##### Start User Verifications #####
describe user('Administrator') do
  it { should exist }
  it { should belong_to_group 'Administrators' }
end
##### End User Verifications #####



##### Start IIS Verifications #####
# Is IIS installed?
describe windows_feature('IIS-Webserver') do
  it{ should be_installed.by('dism') }
end

# Does our website container exist with the right app pool?  Is it running?
describe iis_website('carmax_serverspec') do
  it { should exist }
  it { should be_enabled }
  it { should be_running }
  it { should be_in_app_pool 'carmax_serverspec' }
  it { should have_physical_path 'c:\\carmax_serverspec' }
end

# Verify App Pool exists with correct .NET version
describe iis_app_pool('carmax_serverspec') do
  it { should exist }
  it { should have_dotnet_version('4.0') }
end

# Is IIS running?
describe service('W3SVC') do
  it { should be_enabled }
  it { should have_start_mode('Automatic')}
  it { should be_running }
end

# Is IIS running as LocalSystem?
describe windows_registry_key('HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC') do
  it { should have_property('ObjectName') }
  it { should have_property_value('ObjectName', :type_string, 'LocalSystem') }
end

### Optional Home Page Spot Check
describe command('curl localhost/index.html') do
  its(:stdout) { should match /Hello World!/ }
end
##### End IIS Verifications #####
