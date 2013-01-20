require 'rubygems'
require 'sinatra'
require 'RMagick'

get '/' do
  erb :index
end

get '/image.png' do
  content_type 'image/png'
  size = params[:s].to_i || 48
  file = Magick::Image.new(size, size) do
    self.background_color = "black"
  end

  message = params[:t]
  point_size = size
  text = get_text(point_size)
  margin = size * 0.1
  iteration = 1
  while (point_size >= 10 && text.get_type_metrics(file, message).width > (size - margin)) do
    point_size = (1 - (iteration * 0.1)) * size
    iteration += 1
    text = get_text(point_size)
  end

  puts "  Iteration: #{iteration} Size: #{point_size} Width: #{text.get_type_metrics(file, message).width}"

  text.annotate(file, 0, 0, 0, 0, message) do
    self.fill = '#ffffff'
  end

  file.to_blob { |f| f.format = 'PNG' }
end

def get_text(size)
  Magick::Draw.new do
    self.font_family = 'helvetica neue, helvetica, arial'
    self.pointsize = size 
    self.gravity = Magick::CenterGravity
  end
end

__END__

@@index
<html>
  <head>
    <title>jabwire: texatar</title>
  <head>
  <body>
    <h1>jabwire: texatar</h1>
  </body>
  <script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', 'UA-5196398-3']);
    _gaq.push(['_trackPageview']);
    (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
    })();
  </script>
</html>
