def calculate_hash(text, length)
  result = 0 
  text.each_char { |c| result += c.ord }
  result % length
end

def get_text(size)
  Magick::Draw.new do
    self.font = 'fonts/Gafata-Regular.ttf'
    self.pointsize = size
    self.gravity = Magick::CenterGravity
  end
end
