require 'serverspec'

RSpec.configure do |c|
  c.formatter = 'html'
  c.color = true
end

set :backend, :exec
