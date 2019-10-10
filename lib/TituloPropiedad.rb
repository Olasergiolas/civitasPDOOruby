# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor

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
      @propietario
    end
    
    attr_reader :hipotecado, :nombre, :numCasas, :numHoteles, :propietario
    
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
      if (@hipotecado == true && esEsteElPropietario(jugador) == true)
        jugador.paga(getImporteCancelarHipoteca())
        @hipotecado = false;
        return true
        
      else
        return false
        
      end 
    end
    
    def cantidadCasasHoteles
      suma = @numCasas + @numHoteles
    end
    
    def comprar(jugador)
      booleano = false
      if (tienePropietario == false)
        @propietario = jugador
        jugador.paga(getPrecioCompra)
        booleano = true
      end
      
      return booleano
    end
    
    def construirCasa(jugador)
      booleano = false
      if (esEsteElPropietario(jugador) == true)
        jugador.paga(@precioCompra)                              #No sé cuál se supone que es el precio
        @numCasas = @numCasas + 1
        booleano = true
      end
      
      return booleano
    end
    
    def construirHotel(jugador)
      booleano = false
      if (esEsteElPropietario(jugador) == true)
        jugador.paga(@precioCompra)                              #No sé cuál se supone que es el precio
        @numHoteles = @numHoteles + 1
        booleano = true
      end
      
      return booleano
    end
    
    def derruirCasas(n, jugador)
      if (esEsteElPropietario(jugador) == true && @numCasas >= n)
        @numCasas = @numCasas - n
        return true
        
      else
        return false
      end
    end
    
    def getImporteCancelarHipoteca
      cantidadRecibida = @hipotecaBase*(1+(@numCasas*0.5)+(@numHoteles*2.5))*@@factorInteresesHipoteca
    end
    
    def getPrecioCompra
      
    end
    
    def getPrecioEdificar
      
    end
    
    def getPrecioVenta
      precio = @precioCompra + (@precioEdificar * cantidadCasasHoteles) * @factorRevalorizacion
    end
    
    def hipotecar(jugador)
      if (@hipotecado == false && esEsteElPropietario(jugador) == true)
        jugador.recibe(getImporteHipoteca)
        @hipotecado = true
        return true
        
      else
        return false
      end
    end
    
    def tienePropietario
      
    end
    
    def tramitarAlquiler(jugador)
      if (tienePropietario() == true && esEsteElPropietario(jugador) == false)
        jugador.pagaAlquiler(getPrecioAlquiler)
        @propietario.recibe(getPrecioAlquiler)
      end
    end
    
    def vender(jugador)
      
    end
    
    private
    
    def esEsteElPropietario(jugador)
      booleano = false
      if (@propietario.compareTo(jugador) == true)
        booleano = true
      end
      
      return booleano
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
  end
end
