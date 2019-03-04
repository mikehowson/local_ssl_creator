Gem::Specification.new do |s|
  s.name        = 'localhoster'
  s.version     = '0.0.1'
  s.date        = '2019-03-04'
  s.summary     = "Localhoster SSL creator"
  s.description = "A gem to create an install a self signed certificate for use with local https development"
  s.authors     = ["Mike Howson"]
  s.email       = 'mikehowson@gmail.com'
  s.files       = ['bin/localhoster', 'bin/create_cert.sh']
  s.executables << 'localhoster'
  s.homepage    = 'https://p4.io'
  s.license     = 'MIT'
end
