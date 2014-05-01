require 'aruba/cucumber'

$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require 'geese'

Before do
  set_env 'HOME', File.expand_path(File.join(current_dir, 'home'))
  FileUtils.mkdir_p ENV['HOME']
end
