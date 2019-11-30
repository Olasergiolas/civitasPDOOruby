# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class SorpresaIrCarcel < Sorpresa
    def initialize(tablero)
      
      @tablero = tablero
    end
    
    def aplicarAJugador(actual, todos)
        correcto = jugadorCorrecto(actual, todos)
        if (correcto)
          informe(actual, todos)
          todos[actual].encarcelar(@tablero.numCasillaCarcel)
        end
    end
  end
end
