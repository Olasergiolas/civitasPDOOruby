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
    
    def toString
      puts "#{@nombre}, #{@alquilerBase}, #{@factorRevalorizacion}, #{@hipotecaBase}, hipotecado: #{@hipotecado},
        #{@nombre}, #{@numCasas}, #{@numHoteles}, #{@precioCompra}, #{@precioEdificar}, #{@propietario}"
    end
    
    def getPrecioAlquiler
      if (@hipotecado == true || propietarioEncarcelado() == true)
        precio_alquiler = 0
      
      else
        precio_alquiler = @alquilerBase * (1+(@numCasas * 0.5) + (@numHoteles * 2.5))
      end
    end
    
    def propietarioEncarcelado
      
      if (@propietario.isEncarcelado() == true)
        encarcelado = true
      
      else
        encarcelado = false
      end
    end
  end
end
