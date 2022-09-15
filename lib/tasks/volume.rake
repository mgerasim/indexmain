
namespace :volume do
  desc "TODO"
  task load: :environment do
    puts "Start task volume load"
    #csv_text = File.read('/home/rails/projects/indexmain/DEF-9xx.csv')
    File.readlines('/home/rails/projects/indexmain/DEF-9xx.csv').each do |line|
        volume = Volume.new
        volume.code = line.split(';')[0].to_i
        volume.begin = line.split(';')[1].to_i
        volume.end = line.split(';')[2].to_i
        volume.size = line.split(';')[3].to_i
        volume.operator = line.split(';')[4]
        volume.region = line.split(';')[5]
        volume.unn = line.split(';')[6]
        volume.save
        puts(line.split(';')[0].to_i)
    end
  end

end
