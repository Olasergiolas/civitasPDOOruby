# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'JugadorEspeculador'

module Civitas
  class SorpresaHacerEspeculador < Sorpresa
    def initialize(fianza)
      @fianza = fianza
    end
    
    def aplicarAJugador(actual, todos)
        correcto = jugadorCorrecto(actual, todos)
        if (correcto)
          informe(actual, todos)
          jEsp = JugadorEspeculador.nuevoEspeculador(todos[actual], @fianza)
          todos[actual] = jEsp
        end
    end
    
      def toString
        info = "Hacer Especulador"
      end
  end
end
