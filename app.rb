require 'rubygems'
require 'sinatra'
require 'RMagick'

COLORS = [
  ["#464646", "#e7e7e7"],
  ["#b6cff5", "#0d3472"],
  ["#98d7e4", "#0d3b44"],
  ["#e3d7ff", "#3d188e"],
  ["#fbd3e0", "#711a36"],
  ["#f2b2a8", "#8a1c0a"],
  ["#c2c2c2", "#ffffff"],
  ["#4986e7", "#ffffff"],
  ["#2da2bb", "#ffffff"],
  ["#b99aff", "#ffffff"],
  ["#f691b2", "#994a64"],
  ["#fb4c2f", "#ffffff"],
  ["#ffc8af", "#7a2e0b"],
  ["#ffdeb5", "#824706"],
  ["#fbe983", "#595a57"],
  ["#fdedc1", "#714e07"],
  ["#b3efd3", "#0b4f77"],
  ["#a2dcc1", "#04506e"]
  ]

get '/' do
  erb :index
end

get '/image.png' do
  message = params[:t]

  result = 0
  message.each_char { |c| result += c.ord }
  result = result % COLORS.length
  colors = COLORS[result]

  content_type 'image/png'
  size = params[:s].to_i || 48
  file = Magick::Image.new(size, size) do
    self.background_color = colors[0]
  end

  point_size = (0.8 * size)
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
    self.fill = colors[1]
  end

  file.to_blob { |f| f.format = 'PNG' }
end

def get_text(size)
  Magick::Draw.new do
    self.font = 'fonts/Gafata-Regular.ttf'
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
