#encoding:utf-8
require_relative 'respuestas'
require_relative 'SalidasCarcel'
require_relative 'OperacionesJuego'
require_relative 'OperacionInmobiliaria'
require 'io/console'

module Civitas

  class Vista_textual
    
    def initialize
      @juegoModel
      @in
      @iPropiedad
      @iGestion
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
      lista.each { |l|
        puts tab+index.to_s+"-"+l
        index += 1
      }

      opcion = lee_entero(lista.length,
                          "\n"+tab+"Elige una opción: ",
                          tab+"Valor erróneo")
      return opcion
    end

    
    def comprar
      menu("¿Deseas comprar la calle?", lista_Respuestas)
    end

    def gestionar
      @iGestion = menu("¿Qué gestión inmobiliaria se va a realizar?", lista_Gestiones)
      @iPropiedad = menu("Elige la propiedad.", @juegoModel.getJugadorActual.propiedades) #Supongo que es así pero no estoy seguro
    end

    def mostrarSiguienteOperacion(operacion)
      puts operacion
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
      puts @juegoModel.getJugadorActual.toString
      puts @juegoModel.getCasillaActual.toString
    end
    
    def salirCarcel
      menu("¿De qué forma se va a salir de la cárcel?", lista_Salidas)
    end
  end

end