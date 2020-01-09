require 'eyes_images'

runner = Applitools::ClassicRunner.new
eyes = Applitools::Images::Eyes.new(runner: runner)
batch = Applitools::BatchInfo.new('Applitools Screenshot example')

eyes.batch = batch

Applitools::EyesLogger.log_handler = Logger.new(STDOUT).tap do |l|
  l.level = Logger::INFO
end

begin
  file_path = './PNG_IMG1.png'
  image_bytes = File.read(file_path)
  image = Applitools::Screenshot.from_datastream(image_bytes)

  # Classic API
  eyes.open(app_name: 'Screenshot example app', test_name: 'Screenshot example classic api')
  eyes.check_image(tag: 'By file path', image_path: file_path)
  eyes.check_image(tag: 'By image bytes', image_bytes: image_bytes)
  eyes.check_image(tag: 'By Applitools Screenshot', image: image)
  eyes.check_region(tag: 'Check region example', image: image, region: Applitools::Region.new(200, 200, 100, 100))
  eyes.close

  # Fluent API
  eyes.open(app_name: 'Screenshot example app', test_name: 'Screenshot example fluent api')
  eyes.check('By file path', Applitools::Images::Target.path(file_path))
  eyes.check('By image bytes', Applitools::Images::Target.blob(image_bytes))
  eyes.check('By Applitools Screenshot', Applitools::Images::Target.screenshot(image))
  eyes.check(
    'Check region example',
    Applitools::Images::Target.screenshot(image).region(Applitools::Region.new(200, 200, 100, 100))
  )
  eyes.close
rescue => e
  puts e.message
  eyes.abort
ensure
  puts runner.get_all_test_results
end


