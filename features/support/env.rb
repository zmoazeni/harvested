$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'harvest'
require 'ruby-debug'
require 'artifice'

require 'spec/expectations'

After do
  Artifice.deactivate
end