namespace :test do
    desc "test entire app"
    task :full_test => [:environment] do 
      if !Rails.env.production?  
        sh("rspec --format documentation")
      else
        p "Rails is in production!"
      end
    end
  end