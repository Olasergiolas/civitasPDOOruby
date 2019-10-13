# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require_relative 'Jugador'
require_relative 'TipoCasilla'

module Civitas  
    class Casilla
    
    @@carcel = 0
    def initialize(nombre)
      init
      @nombre = nombre
      @importe
      @tipo = TipoCasilla::DESCANSO
      @mazo
      @sorpresa
      @tituloPropiedad
    end 
    
    def self.new_t(titulo)
      init
      @nombre = titulo.nombre
      @importe
      @tipo = TipoCasilla::CALLE
      @mazo
      @sorpresa
      @tituloPropiedad = titulo
    end
    
    def self.new_c_n(cantidad, nombre)
      init
      @nombre = nombre
      @importe = cantidad
      @tipo = TipoCasilla::IMPUESTO
      @mazo
      @sorpresa
      @tituloPropiedad
    end
    
    def self.new_num_n(numCasillaCarcel, nombre)
      init
      @@carcel = numCasillaCarcel
      @nombre = nombre
      @importe
      @tipo = TipoCasilla::JUEZ
      @mazo
      @sorpresa
      @tituloPropiedad
    end
    
    def self.new_m_n(mazo, nombre)
      init
      @nombre = nombre
      @importe
      @tipo = TipoCasilla::SORPRESA
      @mazo = mazo
      @sorpresa
      @tituloPropiedad
    end
    
    def informe(iactual, todos)
      Diario.instance.ocurre_evento('El jugador #{todos[iactual].nombre} ha caído en una casilla #{@tipo}')
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
      info = 'Casilla #{@nombre} con importe #{@importe}, de tipo #{@tipo}, con un TítuloPropiedad de nombre #{@tituloPropiedad.nombre}'
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
