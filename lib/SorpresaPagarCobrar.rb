
module Civitas
  class SorpresaPagarCobrar < Sorpresa
    def initialize(valor, texto)
      
      @valor = valor
      @texto = texto
    end
    
    def aplicarAJugador(actual, todos)
        correcto = jugadorCorrecto(actual, todos)
        if (correcto)
          informe(actual, todos)
          todos[actual].modificarSaldo(@valor)
        end
    end  
    
    def toString
      info = "Pagar Cobrar"
    end
  end
end
