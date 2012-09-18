Rails.application.config.before_initialize do
  Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each {|l| require l }
end