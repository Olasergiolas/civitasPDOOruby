# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class CasillaJuez < Casilla
    
    @@ccarcel = 0
    def initialize(carcel, n)
      @@carcel = carcel
      @nombre = n
    end
    
    def recibeJugador(iactual, todos)
      correcto = jugadorCorrecto(iactual, todos)
      if (correcto)
        informe(iactual, todos)
        todos[iactual].encarcelar(@@carcel)
      end
    end
    
    def toString
      info = "Juez con carcel en la casilla #{@numCasillaCarcel}"
    end
    
  end
end
