#encoding:utf-8

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
    
    def toString
      info = "Ir Cárcel"
    end
  end
end
