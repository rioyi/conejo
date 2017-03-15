require 'colorize'


#+Construye el tablero
def tablero_conejo(matriz_conejo,ancho)
  for i in 0..15
    a = []
    for j in 0..ancho -1
      a << "| |"
    end
    matriz_conejo << a
  end

  for x in 0..ancho -1
    matriz_conejo[0][rand(ancho-1)] = "|x|"
  end
end

#SOLO PARA TEST
def tablero_coyote(matriz_coyote,ancho)
  for i in 0..15
    a = []
    for j in 0..ancho -1
      a << "| |"
    end
    matriz_coyote << a
  end
end

def insertar_conejos(matriz_conejo,numero_conejos)


end

#Imprime la matriz
def imprimir(matriz_conejo)
  puts ""
  puts "================================================".colorize(:color => :blue, :background => :white)
  puts "================= MADRIGUERA ===================".colorize(:brown)
  puts ""
  puts " CONEJOS".colorize(:white)
  puts ""
  for i in 0..matriz_conejo.length - 1
    #print "  #{i} ".colorize(:white)
    for x in 0..matriz_conejo.length - 1
      print "  #{matriz_conejo[i][x]}"
    end
    puts
  end
  puts ""
  puts "=================== COSECHA =====================".colorize(:green)
  puts "=================================================".colorize(:color => :blue, :background => :white)
  puts ""
  return matriz_conejo
end

#=begin
def imprimir_coyote(matriz_coyote)
  puts "COYOTE"
  puts ""
  for i in 0..matriz_coyote.length - 1
    #print "  #{i} ".colorize(:white)
    for x in 0..matriz_coyote.length - 1
      print "  #{matriz_coyote[i][x]}"
    end
    puts
  end
  puts ""
  puts ""
  return matriz_coyote
end

#=end
def menu_inicial(matriz_conejo,matriz_coyote)
  ancho = 0
  numero_conejos = 0
    loop do
      puts "ingrese el Numero de columnas (el numero max es 15)"
      ancho = gets.chomp.to_i
      break if ancho >= 5 && ancho < 15
    end

    
    loop do
      puts "Ingrese el Numero de conejos"
      numero_conejos = gets.chomp.to_i
      if numero_conejos < ancho && numero_conejos > 5     
        insertar_conejos(matriz_conejo,numero_conejos)
      end
      break if numero_conejos >= 5 && numero_conejos <= ancho
    end
  #end


  tablero_conejo(matriz_conejo,ancho)
  tablero_coyote(matriz_coyote,ancho)
end

#Funcion principal
def main()
  matriz_conejo = []
  matriz_coyote = []
  menu_inicial(matriz_conejo,matriz_coyote)

  
  imprimir(matriz_conejo)
  imprimir_coyote(matriz_coyote)
end

main()