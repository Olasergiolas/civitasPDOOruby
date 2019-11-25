# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class SorpresaPorJugador < Sorpresa
    def initialize(tipo, valor, texto)
      @tipo = tipo
      @valor = valor
      @texto = texto
    end
    
    def aplicarAJugador_porJugador(actual, todos)
      cobrar = Sorpresa.new_tp_v(TipoSorpresa::PAGARCOBRAR, @valor*(todos.size-1))
      pagar = Sorpresa.new_tp_v(TipoSorpresa::PAGARCOBRAR, @valor*-1)    
      
      if (jugadorCorrecto(actual, todos))
        informe(actual, todos)
        
        for i in 0..todos.size-1
          if (i != actual)
            pagar.aplicarAJugador(i, todos)

          else
            cobrar.aplicarAJugador(i, todos)
          end
        end
      end
    end   
    
    def toString
      info = "Sorpresa de tipo #{@tipo}"
    end
    
  end
end
