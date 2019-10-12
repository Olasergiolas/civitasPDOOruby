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
      @salvoconducto
    end
   
    def self.newCopy(otro)
      copia = new(otro.nombre)
      copia.encarcelado = otro.encarcelado
      copia.numCasillaActual = otro.numCasillaActual
      copia.puedeComprar = otro.puedeComprar
      copia.saldo = otro.saldo
      propiedades = otro.propiedades
    end
    
    attr_reader :hotelesMax, :casasMax, :casasPorHotel, :encarcelado, :nombre, :numCasillaActual, :precioLibertad, :saldo, :encarcelado, :puedeComprar, :propiedades
    attr_writer :saldo, :numCasillaActual
    
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
      debeSerlo = false
      
      if !@encarcelado && !tieneSalvoconducto
        debeSerlo = true
      
      elsif !@encarcelado && tieneSalvoconducto
        perderSalvoconducto
        Diario.instance.ocurre_evento('El jugador #{@nombre} se libra de la cárcel')
      end
      
      return debeSerlo      
    end
    
    def enBancarrota
      
    end
    
    def encarcelar(numCasillaCarcel)
      if debeSerEncarcelado
        moverACasilla(numCasillaCarcel)
        @encarcelado = true
        Diario.instance.ocurre_evento('El jugador #{@nombre} ha sido encarcelado')
      end
      
      return @encarcelado
    end
    
    def existeLaPropiedad(ip)
      
    end
    
    def getPremioPasoSalida
      
    end
    
    def hipotecar(ip)
      
    end
    
    def modificarSaldo(cantidad)
      @saldo = @saldo + cantidad
      Diario.instance.ocurre_evento('Se le ha modificado el saldo al jugador #{@nombre}')
      return true
    end
    
    def moverACasilla(numCasilla)
      resultado = false
      
      if !@encarcelado
        @numCasillaActual = numCasilla
        @puedeComprar = false
        Diario.instance.ocurre_evento('El jugador #{@nombre} ha sido movido a la casilla número #{@numCasillaActual}')
        resultado = true
      end
      
      return resultado
    end
    
    def obtenerSalvoconducto(sorpresa)
      resultado = false
      
      if !@encarcelado
        @salvoconducto = sorpresa
        resultado = true
      end
      
      return resultado
    end
    
    def paga(cantidad)
      modificarSaldo(cantidad * (-1))
    end
    
    def pagaAlquiler(cantidad)
      if !@encarcelado
        paga(cantidad)
        
      else
        return false
      end
    end
    
    def pagaImpuesto(cantidad)
      if !@encarcelado
        paga(cantidad)
        
      else
        return false
      end
    end
    
    def pasaPorSalida
      
    end
    
    def perderSalvoConducto
      @salvoconducto.usada
      @salvoconducto = 0
    end
    
    def puedeComprarCasilla
      if @encarcelado
        @puedeComprar = false
        
      else
        @puedeComprar = true
      end
    end
    
    def puedeSalirCarcelPagando
      
    end
    
    def puedoEdificarCasa(propiedad)
      
    end
    
    def puedoEdificarHotel(propiedad)
      
    end
    
    def puedoGastar(precio)
      puedo = false
      
      if !@encarcelado && (saldo >= precio)
        puedo = true
      end
      
      return puedo
    end
    
    def recibe(cantidad)
      if !@encarcelado
        modificarSaldo(cantidad)
        
      else
        return false
      end
    end
    
    def salirCarcelPagando
      
    end
    
    def salirCarcelTirando
      
    end
    
    def tieneAlgoQueGestionar
      
    end
    
    def tieneSalvoconducto
      tiene = false
      
      if @salvoconducto != 0
        tiene = true
      end
      
      return tiene
    end
    
    def toString
      
    end
    
    def vender(ip)
      resultado = false
      
      if !@encarcelado && existeLaPropiedad
        @propiedades[ip].vender(self)  
        @propiedades.delete_at(ip)
        Diario.instance.ocurre_evento('El jugador #{@nombre} ha vendido una propiedad')
        resultado = true
      end
      
      return resultado      
    end
    
    protected :debeSerEncarcelado, :nombre, :propiedades, :saldo
    
    private :existeLaPropiedad, :hotelesMax, :casasMax, :precioLibertad, :getPremioPasoSalida, :perderSalvoConducto, :puedeSalirCarcelPagando, :puedoEdificarCasa, :puedoEdificarHotel, :puedoGastar
    
  end
end
