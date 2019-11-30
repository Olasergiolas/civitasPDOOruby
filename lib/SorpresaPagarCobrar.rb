# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

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
  end
end
