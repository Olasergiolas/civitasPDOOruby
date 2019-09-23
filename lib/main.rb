# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#enconding: UTF-8

module Civitas
  module Operaciones_juego
    AVANZAR = :avanzar
    COMPRAR = :comprar
    GESTIONAR = :gestionar
    SALIR_CARCEL = :salir_carcel
    PASAR_TURNO = :pasar_turno
  end
  
  module TipoCasilla
    CALLE = :calle
    SORPRESA = :sorpresa
    JUEZ = :juez
    IMPUESTO = :impuesto
    DESCANSO = :descanso
  end
  
  module TipoSorpresa
    IRCARCEL = :ircarcel
    IRCASILLA = :ircasilla
    PAGARCOBRAR = :pagarcobrar
    PORCASAHOTEL = :porcasahotel
    PORJUGADOR = :porjugador
    SALIRCARCEL = :salircarcel
  end
  
  class Tablero
    def initialize(cas)
      @numCasillaCarcel
      @porSalida = 0
      @tieneJuez = false
      @casillas = Array.new
      
      if cas >= 1
        @numCasillaCarcel = cas
        
      else
        @numCasillaCarcel = 1
      end
      
      casillas.push('Salida')  
    end
    
    private
    
    def correcto
      
    end
    
    
  end
  
  class Casilla
    attr_reader :nombre
    
    def initialize(n)
      @nombre = n
    end
    
    
  end
  
end