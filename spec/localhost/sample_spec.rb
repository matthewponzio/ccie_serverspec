require 'spec_helper'

# puts 'Starting IIS container verification tests!'

##### Start Networking verifications #####
# RDP is open...right?  Is IIS listening on port 80?
%w{80 443}.each do |ports|
  describe port(ports) do
    it { should be_listening.with('tcp') }
  end
end

# We're not listening for unencrypted telnet connections...right?
describe port(23) do
  it { should_not be_listening }
end

### Optional Home Page Spot Check
describe command('curl localhost/index.html') do
  its(:stdout) { should match /Hello World!/ }
end
##### End IIS Verifications #####
