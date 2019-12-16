
module Civitas
  class SorpresaPorCasaHotel < Sorpresa
    def initialize(valor, texto)
      
      @valor = valor
      @texto = texto
    end
    
    def aplicarAJugador(actual, todos)
        correcto = jugadorCorrecto(actual, todos)
        if (correcto)
          informe(actual, todos)
          todos[actual].modificarSaldo(@valor * (todos[actual].cantidadCasasHoteles))
        end   
    end
    
    def toString
      info = "Por Casa Hotel"
    end
  end
end
