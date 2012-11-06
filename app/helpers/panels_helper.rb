module PanelsHelper
  def compress_css(css)
    compressed_css = Sass::Engine.new(css, syntax: :scss, style: :compressed); 
    compressed_css.render
  end
end
