require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = "test/test_*.rb"  
end

desc "Run tests"
task default: :test

task :build do
  system "gem build cradlepoint.gemspec"
end
