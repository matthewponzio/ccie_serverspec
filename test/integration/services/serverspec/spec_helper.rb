require 'serverspec'

RSpec.configure do |c|
  c.formatter = 'documentation'
end

set :backend, :exec
