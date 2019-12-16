
module Civitas
  class SorpresaIrCasilla < Sorpresa
    def initialize(tablero, valor, texto)
      
      @tablero = tablero
      @valor = valor
      @texto = texto
    end
    
    def aplicarAJugador(actual, todos)
      correcto = jugadorCorrecto(actual, todos)
      if (correcto)
        informe(actual, todos)
        todos[actual].encarcelar(@tablero.numCasillaCarcel)
      end
    end   
    
    def toString
      info = "Ir Casilla"
    end
  end
end
