# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class SorpresaSalirCarcel < Sorpresa
    def initialize(mazo)
      
      @mazo = mazo
    end
    
    def aplicarAJugador(actual, todos)
      alguien_tiene = false

      if (jugadorCorrecto(actual, todos))
        informe(actual, todos)

        for i in 0..todos.size - 1
          next if alguien_tiene

          if (todos[i].tieneSalvoconducto)
            alguien_tiene = true
          end
        end

        if !alguien_tiene
          todos[actual].obtenerSalvoconducto(self)
          salirDelMazo
        end
      end
    end
    
    def salirDelMazo
      @mazo.inhabilitarCartaEspecial(self)      
    end
    
    def usada
        @mazo.habilitarCartaEspecial(self)
    end
  end
end
