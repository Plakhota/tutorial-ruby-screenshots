require 'eyes_images'

runner = Applitools::ClassicRunner.new
eyes = Applitools::Images::Eyes.new(runner: runner)
batch = Applitools::BatchInfo.new('Demo Batch - Images - Ruby')

eyes.batch = batch

Applitools::EyesLogger.log_handler = Logger.new(STDOUT).tap do |l|
  l.level = Logger::INFO
end

begin
  file_path = './applitools.png'
  image_bytes = File.read(file_path)
  image = Applitools::Screenshot.from_datastream(image_bytes)

  eyes.open(app_name: 'Demo App - Images Ruby', test_name: 'Smoke Test - Images Ruby')
  
  eyes.check('By file path', Applitools::Images::Target.path(file_path))
  eyes.check('By image bytes', Applitools::Images::Target.blob(image_bytes))
  eyes.check('By Applitools Screenshot', Applitools::Images::Target.screenshot(image))

  eyes.close
rescue => e
  puts e.message
  eyes.abort
ensure
  puts runner.get_all_test_results
end