namespace :active_record_counter do
  desc "TODO"
  task project_count: :environment do
    puts "project count: #{Project.count}"
  end

  desc "TODO"
  task user_count: :environment do
    puts "users count: #{User.count}"
  end

  desc "TODO"
  task task_count: :environment do
    puts "tasks count: #{Task.count}"
  end

end
