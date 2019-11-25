#encoding: UTF-8
require_relative 'Casilla'
require_relative 'Jugador'

module Civitas
    class CasillaSorpresa < Casilla
      def initialize(nombre, mazo)
        @nombre = nombre
        @mazo = mazo
      end
      
      def recibeJugador(iactual, todos)
        @mazo.siguiente.aplicarAJugador(iactual, todos)
      end
      
      def toString
        info = "Sorpresa"
      end
    end
end
