# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
  class Jugador
    @@casasMax = 4
    @@casasPorHotel = 4
    @@hotelesMax = 4
    @@pasoPorSalida = 1000
    @@precioLibertad = 200
    @@saldoInicial = 7500
    def initialize(nombre)
      @encarcelado
      @nombre = nombre
      @numCasillaActual
      @puedeComprar
      @saldo
      @propiedades = Array.new
    end
   
    def self.newCopy(otro)
      copia = new(otro.nombre)
      copia.encarcelado = otro.encarcelado
      copia.numCasillaActual = otro.numCasillaActual
      copia.puedeComprar = otro.puedeComprar
      copia.saldo = otro.saldo
      propiedades = otro.propiedades
    end
    
    attr_reader :@@hotelesMax, :@nombre, :@numCasillaActual, :@@precioLibertad, :@saldo, :@encarcelado, :@puedeComprar, :@propiedades
    
    def cancelarHipoteca(ip)
      
    end
    
    def cantidadCasasHoteles
      
    end
    
    def compareTo(jugador)
      
    end
    
    def comprar(titulo)
      
    end
    
    def construirCasa(ip)
      
    end
    
    def construirHotel(ip)
      
    end
    
    def debeSerEncarcelado
      
    end
    
    def enBancarrota
      
    end
    
    def encarcelar(numCasillaCarcel)
      
    end
    
    def existeLaPropiedad(ip)
      
    end
    
    def getPremioPasoSalida
      
    end
    
    def getPropiedades
      
    end
    
    def getPuedeComprar
      
    end
    
    def hipotecar(ip)
      
    end
    
    protected :@@casasMax, :@@casasPorHotel, :@@hotelesMax, :@@pasoPorSalida, :@@precioLibertad, :@@saldoInicial, :debeSerEncarcelado, :nombre, :getPropiedades, :saldo
    
    private :existeLaPropiedad, :hotelesMax, :precioLibertad, :getPremioPasoSalida
    
  end
end
