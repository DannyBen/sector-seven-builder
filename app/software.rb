class Software
  include Bobkit::Tasks

  class << self
    def index = @index || YAML.load_file('src/data/software/index.yml').map(&:to_sym)
    def all = index.map { |id| new id }
    def [](id) = new id
  end

  attr_reader :id

  def initialize(id)
    @id = id
    Generator.setup
  end

  def method_missing(method, *) = properties[method]
  def respond_to_missing?(*) = true
  def data_dir = "src/data/software/#{id}"
  def meta_file = "#{data_dir}/meta.yml"
  def description_file = "#{data_dir}/description.md"
  def screenshot_path = "/assets/images/screenshots/#{id}.png"
  def download = "/assets/downloads/#{id}.zip"
  
  def screenshot
    @screenshot ||= File.exist?("src/#{screenshot_path}") ? screenshot_path : nil
  end
  
  def description
    @description ||= markdown "software/#{id}/description" if File.exist? description_file
  end
  
  def properties
    @properties ||= YAML.load_file(meta_file).transform_keys(&:to_sym)
  end
end
