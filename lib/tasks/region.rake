namespace :region do
  desc "TODO"
  task import: :environment do
    puts "Region import started"
    Volume.select(:region).distinct.each do |volume| 
      puts volume.region
      region = Region.create(:title=>volume.region, :timezone=>'')
    end
  end

end
