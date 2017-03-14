#Se debe instalar Colorize antes de jugar (gem install colorize)
#Invocas el Colorize
require 'colorize'

#+Construye el tablero
def tablero(m)
  for i in 0..7
    a = []
    for j in 0..7
      a << "| |"
    end
    m << a
  end
end

#+Imprime la matriz
def imprimir(m)
	puts ""
  puts "================================================".colorize(:color => :blue, :background => :white)
  puts "================= MADRIGUERA ==================="
  puts ""
  puts "       0    1    2    3    4    5    6    7".colorize(:white)
  for i in 0..m.length - 1
    print "  #{i} ".colorize(:white)
    for x in 0..m.length - 1
      print "  #{m[i][x]}"
    end
    puts
  end
  puts ""
  puts "=================== COSECHA ====================="
  puts "=================================================".colorize(:color => :blue, :background => :white)
  puts ""
  return m
end




def main()
	matriz = []
	tablero(matriz)
	imprimir(matriz)



end

main()