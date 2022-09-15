class TaskRunningJob < ApplicationJob
  queue_as :default

  def perform(task)
    task.status = 'Выполняется'
    task.save

    f = File.new(task.filename_output, "a+")
    
    h = {}

    File.readlines(task.filename_input).each do |line|
      line = line.strip

      next if h[line] != nil

      h[line] = true

      tel = line.reverse

      tel = tel[0..9]

      tel = tel.reverse

      puts tel

      code = tel[0..2].to_i

      tel = tel[3..9].to_i

      volume = Volume.where(["code = ? and begin <= ? and end >= ?", code, tel, tel]).first

      region_title = ''

      region_title = volume.region if volume

      region = Region.where(:title => region_title).first

      timezone = ''

      timezone = region.timezone if region

      f.puts(line + ';' + region_title + ';' + timezone )
    end

    f.close()

    task.status = 'Выполнена'
    task.save
  end
end
