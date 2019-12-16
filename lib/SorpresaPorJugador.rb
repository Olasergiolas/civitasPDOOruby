
module Civitas
  class SorpresaPorJugador < Sorpresa
    def initialize(valor, texto)
      
      @valor = valor
      @texto = texto
    end
    
    def aplicarAJugador(actual, todos)
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
      info = "Por Jugador"
    end
    
  end
end
