class Generator
  include Bobkit::Tasks
  include Bobkit::Watcher
  include Colsole

  class << self
    include Bobkit::Tasks

    def setup
      output_folder 'site'
      root_folder 'src'
      markdown_folder 'src/data'
    end
  end

  def initialize = self.class.setup

  def build_html
    say 'rendering html ... '

    softwares = Software.all

    render 'index', layout: 'default', output: 'index', softwares: softwares
    render 'shared/redirect', output: 'software/index'

    softwares.each do |software|
      render 'software/show', layout: 'default',
        output: "software/#{software.id}", software: software
    end

    render 'software/fileblender/info', layout: 'default',
      output: 'software/fileblender/info', software: Software.new(:fileblender)

    render 'software/rpg/samples', layout: 'default',
      output: 'software/rpg/samples', software: Software.new(:rpg)

    rpg = Software.new(:rpg)
    render 'software/rpg/tutorials', layout: 'default',
      output: 'software/rpg/tutorials', software: rpg, selected: nil

    rpg.videos.each do |key, data|
      render 'software/rpg/tutorials', layout: 'default',
        output: "software/rpg/tutorials/#{key}", software: rpg, selected: data
    end

    say 'g`rendered html`', replace: true
  end

  def build_css
    say 'compiling css ... '
    compile_css 'site', output: 'style'
    say 'g`compiled css`', replace: true
  end

  def build_assets
    say 'copying assets ... '
    copy_asset 'images'
    copy_asset 'icons'
    copy_folder 'src/assets/root', output_folder
    say 'g`copied assets`', replace: true
  end

  def build_software
    say 'copying software ... '
    copy_asset 'downloads'
    copy_asset 'rpg-samples'
    say 'g`copied software`', replace: true
  end

  def build_js
    say 'compiling javascripts ... '
    compile_js 'site', output: 'site'
    say 'g`compiled javascripts`', replace: true
  end

  def build_repo_assets
    copy_file 'README.md', "#{output_folder}/README.md"
  end
end
