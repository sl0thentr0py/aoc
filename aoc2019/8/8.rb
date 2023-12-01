WIDTH = 25
HEIGHT = 6
SIZE = WIDTH * HEIGHT

input = File.read('input').strip.chars.map(&:to_i)
layers = input.each_slice(SIZE)

min_zeroes_index = layers.map { |l| l.count(0) }.each_with_index.min.last
l = layers.to_a[min_zeroes_index]
p l.count(1) * l.count(2)

###
def interpolate(pixels)
  head, *tail = pixels

  if head != 2
    head
  else
    interpolate(tail)
  end
end

image = []

SIZE.times do |i|
  pixels = layers.map { |l| l[i] }
  image << interpolate(pixels)
end

image.each_slice(WIDTH).each do |row|
  p row
end
# AHFCB
