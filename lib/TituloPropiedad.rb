# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require './Jugador'

module Civitas
  class TituloPropiedad

    @@factorInteresesHipoteca = 1.1
    def initialize(n, precioBA, factorR, precioBH, precioCom, precioEd)
      @alquilerBase = precioBA
      @factorRevalorizacion = factorR
      @hipotecaBase = precioBH
      @hipotecado = false
      @nombre = n
      @numCasas = 0
      @numHoteles = 0
      @precioCompra = precioCom
      @precioEdificar = precioEd
      @propietario = Jugador.new
    end
    
    attr_reader :@hipotecado, :@nombre, :@numCasas, :@numHoteles, :@propietario
    
    def toString
      puts "#{@nombre}, #{@alquilerBase}, #{@factorRevalorizacion}, #{@hipotecaBase}, hipotecado: #{@hipotecado},
        #{@nombre}, #{@numCasas}, #{@numHoteles}, #{@precioCompra}, #{@precioEdificar}, #{@propietario}"
    end
    
    def propietarioEncarcelado
      
      if (@propietario.isEncarcelado() == true)
        encarcelado = true
      
      else
        encarcelado = false
      end
    end
    
    def acutalizaPropietarioPorConversion(jugador)
      
    end
    
    def cancelarHipoteca(jugador)
      
    end
    
    def cantidadCasasHoteles
      
    end
    
    def comprar(jugador)
      
    end
    
    def construirCasa(jugador)
      
    end
    
    def construirHotel(jugador)
      
    end
    
    def derruirCasas(n, jugador)
      
    end
    
    def getImporteCancelarHipoteca
      cantidadRecibida = @hipotecaBase*(1+(@numCasas*0.5)+(@numHoteles*2.5))*@@factorInteresesHipoteca
    end
    
    def getPrecioCompra
      
    end
    
    def getPrecioEdificar
      
    end
    
    def getPrecioVenta
      
    end
    
    def hipotecar(jugador)
      
    end
    
    def tienePropietario
      
    end
    
    def tramitarAlquiler(jugador)
      
    end
    
    def vender(jugador)
      
    end
    
    private
    
    def esEsteElPropietario(jugador)
      
    end
    
    def getImporteHipoteca
      
    end
    
    def getPrecioAlquiler
      if (@hipotecado == true || propietarioEncarcelado() == true)
        precio_alquiler = 0
      
      else
        precio_alquiler = @alquilerBase * (1+(@numCasas * 0.5) + (@numHoteles * 2.5))
      end
    end
    
    def propietarioEncarcelado
      
    end
  end
end
