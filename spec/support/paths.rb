ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), '../..'))

%w(entities contexts extras).each do |folder|
  $LOAD_PATH << File.join(ROOT_PATH, 'app', folder)
end
