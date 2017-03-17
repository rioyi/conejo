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
    #print "#{i} "
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
    #print "#{i} "
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

def get_keypressed()
  system("stty raw -echo")
  t = STDIN.getc
  system("stty -raw echo")
  
  #derecha(t,matriz_conejo,jugada,)
  return t
end

#------------------------------------------------------------------------------

def move_down(t,matriz_conejo,jugada,matriz_coyote)
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
      #Desaparecer al muerto
      for x in 0..linea1.length-1
        if a1[x] == "|-|".colorize(:red)
          a1[x]= "| |"
          matriz_coyote[jugada][x] = "|*|"
          matriz_coyote[jugada-1][x] = "| |"

          #gets
        end
      end
      matriz_conejo[jugada] = liena2
      matriz_conejo[jugada +1] = linea1

      for z in 0..linea1.length-1

       if  (matriz_conejo[jugada+1][z] == "|♀|" || matriz_conejo[jugada+1][z] == "|♂|")  && matriz_coyote[jugada+1][z] == "|*|"
          matriz_conejo[jugada+1][z] = "|-|".colorize(:red)
          #matriz_conejo[0][0] = "|E|"
        #gets
       end

      end


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
    #gets
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

        #matriz_coyote[14][3] = "|/|"
    elsif jugada_coyote > 0
      
      for i in 0..matriz_coyote[jugada_coyote].length-1
         a1 << matriz_coyote[jugada_coyote][i] #actual
         a3 << matriz_coyote[jugada_coyote - 1][i] #arriba
         a2 << matriz_coyote[jugada_coyote + 1][i] #abajo
      end
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
    if matriz[jugada][r] != "| |" && matriz_conejo[jugada][i] == "| |"
      aux = matriz[jugada][i]
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
end
#-------------------------------------------------------------------------------------------
def choque(matriz_conejo, matriz_coyote, jugada, jugada_coyote)
  conejo = []
  #coyote = []
  for i in 0..matriz_conejo[jugada].length
    a = []
    if (matriz_conejo[jugada][i] == "|♀|" || matriz_conejo[jugada][i] == "|♂|") && matriz_coyote[jugada][i] == "|*|"
      matriz_conejo[jugada][i] = "|-|".colorize(:red)

      #a << jugada
      #a << i
    end
    conejo << a
  end
=begin
  coyote = []
   for i in 0..9
    a = []
    if matriz_coyote[jugada_coyote][i] == "|*|"
      a << jugada_coyote
      a << i
    end
    coyote << a
  end

  todo = conejo + coyote
  #comer(conejo,coyote,matriz_conejo)
=end
  #return todo
end

def comer(conejo,coyote,matriz_conejo)
    for i in 0..conejo.length-1
      for x in 0..conejo.length-1
        columna = x
        fila = i
        if conejo[i][x] != []
          matriz_conejo[0][x] = "xD|"
        end
      end
    end
end



=begin
def choque_coyote(matriz_coyote,coor_2, jugada_coyote)
  coyote = []
   for i in 0..matriz_coyote[0].length-1
    a = []
    if matriz_coyote[jugada_coyote][i] == "|*|"
      a << jugada_coyote
      a << i
    end
    coyote << a
  end

  return coyote 
end
=end








#-------------------------------------------------------------------------------------------

#Funcion principal
def main()
  matriz_conejo = []
  matriz_coyote = []
  #coor_1 = []
  #coor_2 = []
  menu_inicial(matriz_conejo,matriz_coyote)
  
  imprimir(matriz_conejo)
  imprimir_coyote(matriz_coyote)


#loop para jugar
  jugada = 0
  jugada_conejo = 0
  jugada_coyote = 14
  
  loop do    
    print "Presione cualquier tecla (s para salir): "
    t = get_keypressed()   
    
    
    if t == "s"   
        move_down(t,matriz_conejo,jugada,matriz_coyote)

        if jugada == jugada_coyote
          choque(matriz_conejo, matriz_coyote, jugada, jugada_coyote)
        end

        puts jugada += 1

      elsif t == "d"
        move_down(t,matriz_conejo,jugada,matriz_coyote)

      elsif t == "a"
        move_down(t,matriz_conejo,jugada,matriz_coyote)
          
    end
    move_arriba(t,matriz_coyote,jugada_coyote)
    puts jugada_coyote -= 1
    jugada_conejo += 1
    #if jugada_coyote == jugada
      choque(matriz_conejo, matriz_coyote, jugada, jugada_coyote)
      #coor_2 = choque_coyote(matriz_coyote,coor_2, jugada_coyote)
    #end
    
    system("clear")
    imprimir(matriz_conejo)
    imprimir_coyote(matriz_coyote)
    puts "juega conejo #{jugada}"
    puts "juega coyo#{jugada_coyote}"
    puts "juegada conejo 2 #{jugada_conejo}"
    #print coor_1
    #print coor_2

    break if t == "p"
  end


end

main()