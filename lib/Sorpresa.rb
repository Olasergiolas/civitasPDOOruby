# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require_relative 'Diario'
require_relative 'Jugador'
require_relative 'Dado'
require_relative 'Tablero'
require_relative 'Casilla'

module Civitas
    class Sorpresa      
      def jugadorCorrecto(actual, todos)
        correcto = false
        if (actual >= 0 && actual <= todos.length)
          correcto = true
        end
        
        return correcto
      end
      
      def toString
        info = "Sorpresa de tipo #{@tipo}"
      end
      
      private
      
      def informe(actual, todos)
        Diario.instance.ocurre_evento("Aplicando sorpresa al jugador #{todos[actual].nombre}")
      end
    end
end
