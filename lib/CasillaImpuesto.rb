#encoding: UTF-8
require_relative 'Casilla'
require_relative 'Jugador'

module Civitas
    class CasillaImpuesto < Casilla
      def initialize(nombre, importe)
        @nombre = nombre
        @importe = importe
      end

      def recibeJugador(iactual, todos)
        if (jugadorCorrecto(iactual, todos))
          informe(iactual, todos)
          todos[iactual].pagaImpuesto(@importe)
        end
      end

      def toString
        info = "Impuesto de importe #{@importe} y nombre #{@nombre}\n"
      end
    end
end
