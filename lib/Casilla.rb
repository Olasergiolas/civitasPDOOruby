# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require_relative 'Jugador'
require_relative 'TipoCasilla'
require_relative 'TituloPropiedad'

module Civitas  
    class Casilla
    
    @@carcel = 0
    def initialize(nombre, titulo, cantidad, numCasillaCarcel, mazo, tipo = TipoCasilla::DESCANSO)
      init
      @@carcel = numCasillaCarcel
      @nombre = nombre
      @importe = cantidad
      @tipo = tipo
      @mazo = mazo
      @sorpresa = nil
      @tituloPropiedad = titulo
    end 
    
    def self.new_t(titulo)
      new(nil, titulo, 0, 0, nil, TipoCasilla::CALLE)
    end
    
    def self.new_c_n(cantidad, nombre)
      new(nombre, nil, cantidad, 0, nil, TipoCasilla::IMPUESTO)
    end
    
    def self.new_num_n(numCasillaCarcel, nombre)
      new(nombre, nil, 0, numCasillaCarcel, nil, TipoCasilla::JUEZ)
    end
    
    def self.new_m_n(mazo, nombre)
      new(nombre, nil, 0, 0, mazo, TipoCasilla::SORPRESA)
    end
    
    def informe(iactual, todos)
      Diario.instance.ocurre_evento("El jugador #{todos[iactual].nombre} ha caído en una casilla #{@tipo}")
      toString
    end
    
    def jugadorCorrecto(iactual, todos)
      correcto = false
      if (iactual > 0 && iactual <= todos.size)
        correcto = true
      end
      
      return correcto
    end
    
    def recibeJugador(iactual, todos)
      
    end
    
    def recibeJugador_calle(iactual, todos)
      
    end
    
    def recibeJugador_impuesto(iactual, todos)
      if jugadorCorrecto
        informe(iactual, todos)
        todos[iactual].pagaImpuesto(@importe)
      end
    end
    
    def recibeJugador_juez(iactual, todos)
      if jugadorCorrecto
        informe(iactual, todos)
        todos[iactual].encarcelar(@@carcel)
      end
    end
    
    def recibeJugador_sorpresa(iactual, todos)
      
    end
    
    def toString
      info = "Casilla #{@nombre} con importe #{@importe}, de tipo #{@tipo}, con un TítuloPropiedad de nombre"
    end
    
    def init
      @mazo                                           #Qué entendemos por un valor adecuado???????
      @sorpresa
      @tituloPropiedad
      @importe = 0
    end
    
    attr_reader :nombre, :tituloPropiedad
  end 
end
