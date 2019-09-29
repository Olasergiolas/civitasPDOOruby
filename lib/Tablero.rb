# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require './Casilla'

module Civitas
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
        porSalida += 1
        
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
end
