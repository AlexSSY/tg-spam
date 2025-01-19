# app/services/avatar_generator.rb
class AvatarGenerator
  def self.generate(full_name)
    initial = full_name.strip[0].upcase
    colors = [ "#FF5733", "#33FF57", "#3357FF", "#FF33A1", "#FFD133" ]
    background_color = colors[full_name.hash % colors.size]

    tempfile = Tempfile.new([ "avatar", ".png" ], binmode: true)
    image = MiniMagick::Image.new(tempfile) do |img|
      img.background_color = background_color
    end

    # Add text in the center
    image.combine_options do |config|
      config.resize "200x200"
      config.gravity "Center"
      config.font "Arial"
      config.fill "white"
      config.pointsize "100"
      config.draw "text 0,0 '#{initial}'"
    end

    # Write the image to a Tempfile for attachment
    image.write(tempfile.path)
    tempfile.rewind

    tempfile
  end
end
