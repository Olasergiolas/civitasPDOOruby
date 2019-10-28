# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor

require_relative 'Jugador'

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
      @propietario = nil
    end
    
    attr_reader :hipotecado, :nombre, :numCasas, :numHoteles, :propietario, :precioCompra, :precioEdificar
    
    def toString
      puts "#{@nombre}, #{@alquilerBase}, #{@factorRevalorizacion}, #{@hipotecaBase}, hipotecado: #{@hipotecado},
        #{@nombre}, #{@numCasas}, #{@numHoteles}, #{@precioCompra}, #{@precioEdificar}, #{@propietario}"
    end
    
    def propietarioEncarcelado
      
      if (@propietario.isEncarcelado())
        encarcelado = true
      
      else
        encarcelado = false
      end
    end
    
    def acutalizaPropietarioPorConversion(jugador)
      @propietario = jugador
    end
    
    def cancelarHipoteca(jugador)
      retorno = false
      if (@hipotecado && esEsteElPropietario(jugador))
        jugador.paga(getImporteCancelarHipoteca())
        @hipotecado = false
        retorno = true
      end
    end
    
    def cantidadCasasHoteles
      suma = @numCasas + @numHoteles
    end
    
    def comprar(jugador)
      booleano = false
      if (!tienePropietario)
        @propietario = jugador
        jugador.paga(getPrecioCompra)
        booleano = true
      end
    end
    
    def construirCasa(jugador)
      booleano = false
      if (esEsteElPropietario(jugador))
        jugador.paga(@precioCompra)                              #No sé cuál se supone que es el precio
        @numCasas = @numCasas + 1
        booleano = true
      end
      
      return booleano
    end
    
    def construirHotel(jugador)
      booleano = false
      if (esEsteElPropietario(jugador))
        jugador.paga(@precioCompra)                              #No sé cuál se supone que es el precio
        @numHoteles = @numHoteles + 1
        booleano = true
      end
      
      return booleano
    end
    
    def derruirCasas(n, jugador)
      if (esEsteElPropietario(jugador) && @numCasas >= n)
        @numCasas = @numCasas - n
        return true
        
      else
        return false
      end
    end
    
    def getImporteCancelarHipoteca
      cantidadRecibida = getImporteHipoteca*@@factorInteresesHipoteca
    end
    
    def getPrecioVenta
      precio = @precioCompra + (@precioEdificar * cantidadCasasHoteles) * @factorRevalorizacion
    end
    
    def hipotecar(jugador)
      if (!@hipotecado && esEsteElPropietario(jugador))
        jugador.recibe(getImporteHipoteca)
        @hipotecado = true
        return true
        
      else
        return false
      end
    end
    
    def tienePropietario
      tiene = false
      if @propietario != nil
        tiene = true
      end
    end
    
    def tramitarAlquiler(jugador)
      if (tienePropietario() && !esEsteElPropietario(jugador))
        jugador.pagaAlquiler(getPrecioAlquiler)
        @propietario.recibe(getPrecioAlquiler)
      end
    end
    
    def vender(jugador)
      resultado = false
      if (esEsteElPropietario(jugador) && !@hipotecado)
        jugador.recibe(getPrecioVenta)
        @propietario = nil
        @numCasas = 0
        @numHoteles = 0
        resultado = true
      end
    end
    
    private
    
    def esEsteElPropietario(jugador)
      booleano = false
      if (@propietario.nombre == jugador.nombre)
        booleano = true
      end
      
      return booleano
    end
    
    def getImporteHipoteca
      importe = @hipotecaBase*(1+(@numCasas*0.5)+(@numHoteles*2.5))
    end
    
    def getPrecioAlquiler
      if (@hipotecado || propietarioEncarcelado())
        precio_alquiler = 0
      
      else
        precio_alquiler = @alquilerBase * (1+(@numCasas * 0.5) + (@numHoteles * 2.5))
      end
    end
  end
end
