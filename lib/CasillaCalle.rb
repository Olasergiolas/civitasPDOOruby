#encoding: UTF-8
require_relative 'Casilla'
require_relative 'Jugador'
require_relative 'TituloPropiedad'

module Civitas
    class CasillaCalle < Casilla
      def initialize(titulo)
        @tituloPropiedad = titulo
      end
      
      def recibeJugador(iactual, todos)
        if (jugadorCorrecto(iactual, todos))
          informe(iactual, todos)
          jugador = todos[iactual]
          if (!@tituloPropiedad.tienePropietario)
            jugador.puedeComprarCasilla
          else
            @tituloPropiedad.tramitarAlquiler(jugador)
          end
        end
      end
      
      def toString
        info = "Calle #{@tituloPropiedad.toString}"
      end
      
      attr_reader :tituloPropiedad
    end
end
