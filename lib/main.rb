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
    
    attr_reader :numCasillaCarcel
    
    def getPorSalida
      if @porSalida > 0
        @porSalida -= 1
        @porSalida + 1              #Supongo que se hace así?
        
      else
        @porSalida
      end
    end
    
    def añadeCasilla(casilla)
      carcel = Casilla.new("Cárcel")
      
      
      if (casillas.length == numCasillaCarcel)
        casillas.push(carcel)
      end
      
      casillas.push(casilla)
      
      while (casillas.length == numCasillaCarcel)
        casillas.push(carcel)
      end
    end
    
    def añadeJuez
      casillajuez = Casilla.new("Juez")
      if @tieneJuez == false
        casillas.push(casillajuez)
        @tieneJuez = true
      end
    end
    
    def getCasilla(n)
      if n <= casillas.length
        casillas[n]
        
      else
        nil
      end
    end
    
    def nuevaPosicion(actual, tirada)
      desplazamiento = actual + tirada
      if (correcto == true && desplazamiento >= @casillas.length)
        desplazamiento %= @casillas.length
        porSalida++
        
      elsif correcto == false
        desplazamiento = -1
        
      end
      
     def calcularTirada(origen, destino)
       tirada = destino - origen
       if tirada < 0
         tirada += @casillas.length
       end
     end
      
    end
    
    
    private
    
      def correcto
        correcto = false
        
        if (@casillas.length > @numCasillaCarcel && @tieneJuez == true)
          correcto = true
        end
        
      end
      
      def correcto(n)
        correcto = false
        
        if (correcto == true && n <= @casillas.length)
          correcto = true
        end
      end
  end
  
  class Casilla
    attr_reader :nombre
    
    def initialize(n)
      private
        @nombre = n
    end 
  end  
  
  class Diario
    include Singleton
    
    def initialize
      @eventos = []
    end
    
  end
end