# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

module Civitas  
    class Casilla
    
    @@carcel
    def initialize(nombre)
        @nombre = nombre
        @importe
        @tipo
        @mazo
        @sorpresa
        @tituloPropiedad
    end 
    
    def self.initialize_t(titulo)
      @nombre
      @importe
      @tipo
      @mazo
      @sorpresa
      @tituloPropiedad = titulo
    end
    
    def self.initialize_c_n(cantidad, nombre)
      @nombre = nombre
      @importe = cantidad
      @tipo
      @mazo
      @sorpresa
      @tituloPropiedad
    end
    
    def self.initialize_num_n(numCasillaCarcel, nombre)
      @@carcel = numCasillaCarcel
      @nombre = nombre
      @importe
      @tipo
      @mazo
      @sorpresa
      @tituloPropiedad
    end
    
    def self.initialize_m_n(mazo, nombre)
      @nombre = nombre
      @importe
      @tipo
      @mazo = mazo
      @sorpresa
      @tituloPropiedad
    end
    
    def informe(iactual, todos)
      
    end
    
    def jugadorCorrecto(iactual, todos)
      
    end
    
    def recibeJugador(iactual, todos)
      
    end
    
    def recibeJugador_calle(iactual, todos)
      
    end
    
    def recibeJugador_impuesto(iactual, todos)
      
    end
    
    def recibeJugador_juez(iactual, todos)
      
    end
    
    def recibeJugador_sorpresa(iactual, todos)
      
    end
    
    def toString
      
    end
    
    attr_reader :nombre, :tituloPropiedad
  end 
end
