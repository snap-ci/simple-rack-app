task :test do
  puts "Running tests"
  (1..10).each do |i|
    puts "."
    sleep 1
  end
end

namespace :db do
  %w(drop create migrate test:prepare).each do |t|
    task t
  end
end
