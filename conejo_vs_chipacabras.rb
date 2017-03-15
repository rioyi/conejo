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
Җ
def insertar_conejos(matriz_conejo,numero_conejos)
  if numero_conejos % 2 == 0
    hembras = numero_conejos / 2
    varones = numero_conejos / 2
  else
    hembras = numero_conejos / 2
    varones = numero_conejos - hembras
  end

cuenta_hembra = 0
cuenta_varones = 0
indice = 0
  loop do
    indice = rand(matriz_conejo[0].length-1)
      if (matriz_conejo[0][indice] == "| |" && hembras != cuenta_hembra && cuenta_hembra < matriz_conejo[0].length-1) 
        matriz_conejo[0][indice] = "|♀|"
        cuenta_hembra += 1
        indice += 1
      end
      if (matriz_conejo[0][indice] == "| |" && varones != cuenta_varones && cuenta_varones < matriz_conejo[0].length-1)      
        matriz_conejo[0][indice] = "|♂|"
        cuenta_varones += 1
        indice += 1
      end
    break if (cuenta_varones+cuenta_hembra) == numero_conejos
  end
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

    puts "Ingrese el Numero de conejos"
    numero_conejos = gets.chomp.to_i

=begin
    loop do
      puts "Ingrese el Numero de conejos"
      numero_conejos = gets.chomp.to_i
      if numero_conejos < ancho && numero_conejos > 5     
        insertar_conejos(matriz_conejo,numero_conejos)
      end
      break if numero_conejos >= 5 && numero_conejos <= ancho
    end
=end
  #end


  tablero_conejo(matriz_conejo,ancho)
  tablero_coyote(matriz_coyote,ancho)
  insertar_conejos(matriz_conejo,numero_conejos)
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