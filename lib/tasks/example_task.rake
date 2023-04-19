namespace :example_task do
   desc 'Greeting message Example task'

   task greet_the_user: :environment do
    puts "hello user how are you   "
   end
end