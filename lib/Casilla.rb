# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require_relative 'Jugador'
require_relative 'TituloPropiedad'

module Civitas  
    class Casilla
    
    def initialize(n)
      @nombre = n
    end
    
    def informe(iactual, todos)
      Diario.instance.ocurre_evento("El jugador #{todos[iactual].nombre} ha caido en una casilla #{toString}")
    end
    
    def jugadorCorrecto(iactual, todos)
      correcto = false
      if (iactual >= 0 && iactual <= todos.size)
        correcto = true
      end
      
      return correcto
    end
    
    def recibeJugador(iactual, todos)
      correcto = jugadorCorrecto(iactual, todos)
      if (correcto)
        informe(iactual, todos)
      end
    end
    
    def toString
      info = "Descanso, casilla #{@nombre}"
    end
    
    attr_reader :nombre
  end 
end
  