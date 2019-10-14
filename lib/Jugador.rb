# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'TituloPropiedad'
require_relative 'Diario'

module Civitas
  class Jugador
    @@casasMax = 4
    @@casasPorHotel = 4
    @@hotelesMax = 4
    @@pasoPorSalida = 1000
    @@precioLibertad = 200
    @@saldoInicial = 7500
    def initialize(nombre)
      @encarcelado = false
      @nombre = nombre
      @numCasillaActual = 0
      @puedeComprar = false
      @saldo = 0
      @propiedades = Array.new
      @salvoconducto = false
    end
   
    def self.newCopy(otro)                                #Arreglar
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
      suma = 0
      for i in 1..@propiedades.size
        suma = suma + @propiedades[i].cantidadCasasHoteles
      end
      
      return suma
    end
    
    def <=>(jugador)
      saldo <=> jugador.saldo
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
        Diario.instance.ocurre_evento("El jugador #{@nombre} se libra de la carcel")
      end
      
      return debeSerlo      
    end
    
    def enBancarrota
      broke = false
      if @saldo < 0
        broke = true
      end
      
      return broke
    end
    
    def encarcelar(numCasillaCarcel)
      if debeSerEncarcelado
        moverACasilla(numCasillaCarcel)
        @encarcelado = true
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha sido encarcelado")
      end
      
      return @encarcelado
    end
    
    def existeLaPropiedad(ip)
      existe = false
      if @propiedades.fetch(ip, false)
        existe = true
      end
      
      return existe
    end
    
    def getPremioPasoSalida
      @saldo = @saldo + 1000
    end
    
    def hipotecar(ip)
      
    end
    
    def modificarSaldo(cantidad)
      @saldo = @saldo + cantidad
      Diario.instance.ocurre_evento("Se le ha modificado el saldo al jugador #{@nombre}")
      return true
    end
    
    def moverACasilla(numCasilla)
      resultado = false
      
      if !@encarcelado
        @numCasillaActual = numCasilla
        @puedeComprar = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha sido movido a la casilla numero #{@numCasillaActual}")
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
      modificarSaldo(1000)
      Diario.instance.ocurre_evento("El jugador #{@nombre} ha pasado por la salida")
      return true
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
      puede = false
      
      if @saldo >= 200
        puede = true
      end
    end
    
    def puedoEdificarCasa(propiedad)
      puedo = false
      if @propiedad.esEsteElPropietario(self) && propiedad.numCasas < 4 && @saldo >= propiedad.precioEdificar
        puedo = true        
      end
    end
    
    def puedoEdificarHotel(propiedad)
      puedo = false
      if @propiedad.esEsteElPropietario(self) && propiedad.numHoteles < 4 && propiedad.numCasas == 4 && @saldo >= propiedad.precioEdificar
        puedo = true
      end
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
      resultado = false
      
      if @encarcelado && puedeSalirCarcelPagando
        paga(200)
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} paga para salir de la carcel")
        resultado = true
      end
    end
    
    def salirCarcelTirando
      resultado = false
      
      if @encarcelado && Dado.instance.salgoDeLaCarcel
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} sale de la carcel con un 5")
        resultado = true
      end
    end
    
    def tieneAlgoQueGestionar
      tienePropiedades = false
      
      if @propiedades.size > 0
        tienePropiedades = true
      end
    end
    
    def tieneSalvoconducto
      tiene = false
      
      if @salvoconducto != 0
        tiene = true
      end
    end
    
    def toString
      info = "Jugador #{@nombre} en la casilla #{@numCasillaActual} con saldo #{@saldo}. Salvoconducto? #{salvoconducto},
              Puede comprar? #{@puedeComprar}, Encarcelado? #{@encarcelado}"
    end
    
    def vender(ip)
      resultado = false
      
      if !@encarcelado && existeLaPropiedad
        @propiedades[ip].vender(self)  
        @propiedades.delete_at(ip)
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha vendido una propiedad")
        resultado = true
      end
      
      return resultado      
    end
    
    protected :debeSerEncarcelado, :nombre, :propiedades, :saldo
    
    private :existeLaPropiedad, :hotelesMax, :casasMax, :precioLibertad, :getPremioPasoSalida, :perderSalvoConducto, :puedeSalirCarcelPagando, :puedoEdificarCasa, :puedoEdificarHotel, :puedoGastar
    
  end
end
