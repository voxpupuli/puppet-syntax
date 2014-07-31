require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')

require 'gem_publisher'
task :publish_gem do
  gem = GemPublisher.publish_if_updated('puppet-syntax.gemspec', :rubygems)
  puts "Published #{gem}" if gem
end

task :default => [:spec]
