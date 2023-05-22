class Software
  class << self
    def index
      @index || YAML.load_file('src/data/software/index.yml').map(&:to_sym)
    end

    def all
      index.map { |id| new id }
    end
  end

  attr_reader :id

  def initialize(id)
    @id = id
  end

  def method_missing(method, *)
    properties[method]
  end

  def respond_to_missing?(*)
    true
  end

  def properties
    @properties ||= YAML.load_file(meta_file).transform_keys(&:to_sym)
  end

  def data_dir
    "src/data/software/#{id}"
  end

  def meta_file
    "#{data_dir}/meta.yml"
  end

  def description_file
    "#{data_dir}/description.md"
  end

  def description
    @description ||= markdown "software/#{id}/description" if File.exist? description_file
  end

  def screenshot
    "/assets/images/screenshots/#{id}.png"
  end

  def download
    "/assets/downloads/#{id}.zip"
  end
end
