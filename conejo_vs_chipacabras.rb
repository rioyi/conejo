require 'colorize'

#-----------------------------------------------------------------------------
#+Construye el tablero
def tablero_conejo(matriz_conejo,ancho)
  for i in 0..14
    a = []
    for j in 0..ancho -1
      a << "| |"
    end
    matriz_conejo << a
  end
end
#------------------------------------------------------------------------------
#SOLO PARA TEST
def tablero_coyote(matriz_coyote,ancho)
  for i in 0..14
    a = []
    for j in 0..ancho -1
      a << "| |"
    end
    matriz_coyote << a
  end
end

#-------------------------------------------------------------------------------

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
    indice = rand(matriz_conejo[0].length)
      if (matriz_conejo[0][indice] == "| |" && hembras != cuenta_hembra) 
        matriz_conejo[0][indice] = "|♀|"
        cuenta_hembra += 1
        #indice += 1
      end
      if (matriz_conejo[0][indice] == "| |" && varones != cuenta_varones)      
        matriz_conejo[0][indice] = "|♂|"
        cuenta_varones += 1
        #indice += 1
      end
      puts "Hembras #{cuenta_hembra}"
      puts "Varores #{cuenta_varones}"
    break if (cuenta_varones+cuenta_hembra) == (hembras+varones)
  end
end

#---------------------------------------------------------------------

def insertar_coyotes(matriz_coyote,numero_conejos)
  cuenta_coyote = 0
  indice = 0

  loop do
    indice = rand(matriz_coyote[0].length)
    if (matriz_coyote[14][indice] == "| |" && cuenta_coyote <= numero_conejos)
      matriz_coyote[14][indice] = "|*|"
      cuenta_coyote += 1
    end
    break if cuenta_coyote == numero_conejos
  end
  
end


#---------------------------------------------------------------------------

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
      if matriz_conejo[i][x] == "|♀|"
        print "  #{matriz_conejo[i][x]}".colorize(:red)
      elsif matriz_conejo[i][x] == "|♂|"
        print "  #{matriz_conejo[i][x]}".colorize(:blue)
      else
        print "  #{matriz_conejo[i][x]}"
      end     
    end
    puts
  end
  puts ""
  puts "=================== COSECHA =====================".colorize(:green)
  puts "=================================================".colorize(:color => :blue, :background => :white)
  puts ""
  return matriz_conejo
end

#-------------------------------------------------------------------------------

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

#-------------------------------------------------------------------------------
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
  insertar_coyotes(matriz_coyote,numero_conejos)
end

def get_keypressed(matriz_conejo,jugada,matriz_coyote,jugada_coyote)
  system("stty raw -echo")
  t = STDIN.getc
  system("stty -raw echo")
  move_down(t,matriz_conejo,jugada)
  move_arriba(t,matriz_coyote,jugada_coyote)
  #derecha(t,matriz_conejo,jugada,)
  return t
end

#------------------------------------------------------------------------------

def move_down(t,matriz_conejo,jugada)
  #jugada = 0
  if t == "s"  && jugada < 14
    a1 = []
    a2 = []
    for i in 0..matriz_conejo[jugada].length-1
      a1 << matriz_conejo[jugada][i]
      a2 << matriz_conejo[jugada + 1][i]
    end
      linea1 = a1
      liena2 = a2

      matriz_conejo[jugada] = liena2
      matriz_conejo[jugada +1] = linea1
  elsif t == "d" && jugada < 14
    aux = ""
    i = 1
    r = 0
    loop do
      if matriz_conejo[jugada][r] != "| |" && matriz_conejo[jugada][i] == "| |"
        aux = matriz_conejo[jugada][i]
        matriz_conejo[jugada][i] = matriz_conejo[jugada][r]
        matriz_conejo[jugada][r] = aux
        i += 2
        r += 2
      else
        i += 1
        r += 1
      end
    break if i > matriz_conejo[0].length-1
    end
  elsif t == "a" && jugada < 14
    aux = ""
    i = matriz_conejo[0].length-2
    r = matriz_conejo[0].length-1
    loop do
      if matriz_conejo[jugada][r] != "| |" && matriz_conejo[jugada][i] == "| |"
        aux = matriz_conejo[jugada][i]
        matriz_conejo[jugada][i] = matriz_conejo[jugada][r]
        matriz_conejo[jugada][r] = aux
        i -= 2
        r -= 2
      else
        i -= 1
        r -= 1
      end
    break if i < 0
    end
  end        
end

#-----------------------------------------------------------------------------

def move_arriba(t,matriz_coyote,jugada_coyote)
  #jugada = 0
    #jugada_coyote  
    a1 = []
    a2 = []
    a3 = []
    if jugada_coyote == 14
      for i in 0..matriz_coyote[jugada_coyote].length-1
        a1 << matriz_coyote[jugada_coyote][i]
        a2 << matriz_coyote[jugada_coyote - 1][i]
      end
        linea1 = a1
        liena2 = a2
        matriz_coyote[jugada_coyote] = liena2
        matriz_coyote[jugada_coyote - 1] = linea1

        matriz_coyote[14][3] = "|/|"
    else
      for i in 0..matriz_coyote[jugada_coyote].length-1
         a1 << matriz_coyote[jugada_coyote][i] #actual
         a3 << matriz_coyote[jugada_coyote - 1][i] #arriba
         a2 << matriz_coyote[jugada_coyote + 1][i] #abajo
      end
        #linea1 = a1
        #liena2 = a2
        #linea3 = a3
        #aux = a3
        #a3 = a1
        #a1 = aux
        #matriz_coyote[jugada_coyote] = liena2
        #matriz_coyote[jugada_coyote - 1] = linea1
        aux = a3
        matriz_coyote[jugada_coyote-1] = a1
        matriz_coyote[jugada_coyote] = a2
        matriz_coyote[jugada_coyote + 1] = aux
    end
end

#-------------------------------------------------------------------------------------------

def derecha(matriz_conejo, jugada)

  aux = ""
  i = 1
  r = 0
  loop do
    if matriz[jugada][r] != "| |" && matriz[jugada][i] == "| |"
      aux = matriz[jugada][i]
      matriz[jugada][i] = matriz[jugada][r]
      matriz[jugada][r] = aux
      i += 2
      r += 2
    else
      i += 1
      r += 1
    end
    break if i > matriz_conejo[0].length-1
  end
end


#-------------------------------------------------------------------------------------------

#Funcion principal
def main()
  matriz_conejo = []
  matriz_coyote = []
  menu_inicial(matriz_conejo,matriz_coyote)
  
  imprimir(matriz_conejo)
  imprimir_coyote(matriz_coyote)


#loop para jugar
  jugada = 0
  jugada_coyote = 14
  loop do
    
    print "Presione cualquier tecla (s para salir): "
    t = get_keypressed(matriz_conejo,jugada,matriz_coyote,jugada_coyote)
    if t == "s"
      puts jugada += 1
    end
    puts jugada_coyote -= 1
    
    system("clear")
    imprimir(matriz_conejo)
    imprimir_coyote(matriz_coyote)
    puts "estas #{jugada}"
    puts "juega coyo#{jugada_coyote}"

    break if t == "p"
  end


end

main()