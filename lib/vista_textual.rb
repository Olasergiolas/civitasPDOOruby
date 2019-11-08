#encoding:utf-8
require_relative 'respuestas'
require_relative 'SalidasCarcel'
require_relative 'OperacionesJuego'
require_relative 'OperacionInmobiliaria'
require 'io/console'

module JuegoTexto

  class Vista_textual
    include Civitas
    
    def initialize
      @juegoModel
      @iPropiedad = -1
      @iGestion = -1
    end
    
    attr_reader :iGestion, :iPropiedad

    def mostrar_estado(estado)
      puts estado
    end
    
    def pausa
      print "Pulsa una tecla"
      STDIN.getch
      print "\n"
    end

    def lee_entero(max,msg1,msg2)
      ok = false
      begin
        print msg1
        cadena = gets.chomp
        begin
          if (cadena =~ /\A\d+\Z/)
            numero = cadena.to_i
            ok = true
          else
            raise IOError
          end
        rescue IOError
          puts msg2
        end
        if (ok)
          if (numero >= max)
            ok = false
          end
        end
      end while (!ok)

      return numero
    end



    def menu(titulo,lista)
      tab = "  "
      puts titulo
      index = 0
=begin      lista.each { |l|
        puts tab+index.to_s+"-"+l
        index += 1
=end      }

      opcion = lee_entero(lista.length,
                          "\n"+tab+"Elige una opción: ",
                          tab+"Valor erróneo")
      return opcion
    end

    
    def comprar
      lista_Respuestas = [Respuestas::NO, Respuestas::SI]
      menu("¿Deseas comprar la calle?", lista_Respuestas)
    end

    def gestionar
      lista_Gestiones = [GestionesInmobiliarias::VENDER, GestionesInmobiliarias::HIPOTECAR, GestionesInmobiliarias::CANCELAR_HIPOTECA,
      GestionesInmobiliarias::CONSTRUIR_CASA, GestionesInmobiliarias::CONSTRUIR_HOTEL, GestionesInmobiliarias::TERMINAR]      
      @iGestion = menu("¿Qué gestión inmobiliaria se va a realizar?", lista_Gestiones)
      @iPropiedad = menu("Elige la propiedad.", @juegoModel.getJugadorActual.propiedades) #Supongo que es así pero no estoy seguro
    end

    def mostrarSiguienteOperacion(operacion)
      puts operacion
      return operacion
    end

    def mostrarEventos
      while (Diario.instance.eventos_pendientes)
        puts Diario.instance.leer_evento
      end
    end

    def setCivitasJuego(civitas)
         @juegoModel=civitas
         self.actualizarVista
    end

    def actualizarVista
      auxJ = @juegoModel.getJugadorActual
      auxC = @juegoModel.getCasillaActual
      
      puts auxJ.toString      
      puts auxC.toString
    end
    
    def salirCarcel
      lista_Salidas = [SalidasCarcel::PAGANDO, SalidasCarcel::TIRANDO]
      menu("¿De qué forma se va a salir de la cárcel?", lista_Salidas)
    end
  end

end
