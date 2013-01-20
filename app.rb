require 'rubygems'
require 'sinatra'
require 'RMagick'
require './lib/helpers'

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

get '/:size/:id.png' do
  message = params[:id]
  size    = params[:size].to_i
  colors  = COLORS[calculate_hash(message, COLORS.length)]
  file    = Magick::Image.new(size, size) { self.background_color = colors[0] }

  # Most text will fit in 80% of the size of the image
  # Check the actual width and if over, iterate until it fits
  # or we are too small
 
  point_size = (0.8 * size)
  text = get_text(point_size)
  margin = size * 0.1
  iteration = 1
  while (point_size >= 10 && text.get_type_metrics(file, message).width > (size - margin)) do
    point_size = (1 - (iteration * 0.1)) * size
    iteration += 1
    text = get_text(point_size)
  end

  text.annotate(file, 0, 0, 0, 0, message) { self.fill = colors[1] }

  content_type 'image/png'
  file.to_blob { |f| f.format = 'PNG' }
end

