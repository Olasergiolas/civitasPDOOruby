# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'TituloPropiedad'
require_relative 'Diario'

module Civitas
  class Jugador
    @casasMax = 4
    @@casasPorHotel = 4
    @hotelesMax = 4
    @@pasoPorSalida = 1000
    @@precioLibertad = 200
    @@saldoInicial = 7500
    def initialize(nombre, encarcelado = false, numCasillaActual = 0, puedeComprar = false, saldo = @@saldoInicial, propiedades = Array.new, salvoconducto = nil)
      @encarcelado = encarcelado
      @nombre = nombre
      @numCasillaActual = numCasillaActual
      @puedeComprar = puedeComprar
      @saldo = saldo
      @propiedades = propiedades
      @salvoconducto = salvoconducto
    end
    
    def self.copia(otroJugador)   
      jugador = new(otroJugador.nombre, otroJugador.encarcelado, otroJugador.numCasillaActual, otroJugador.puedeComprar, otroJugador.saldo, otroJugador.propiedades, otroJugador.salvoconducto)
      jugador
    end
    
    def desde(otroJugador)
      @encarcelado = otroJugador.encarcelado
      @nombre = otroJugador.nombre
      @numCasillaActual = otroJugador.numCasillaActual
      @puedeComprar = otroJugador.puedeComprar
      @saldo = otroJugador.saldo
      @propiedades = otroJugador.propiedades
      @salvoconducto = otroJugador.salvoconducto
    end
    
    def self.CasasMax
      @casasMax
    end
    
    def getCasasMax
      self.class.CasasMax
    end
    
    def self.HotelesMax
      @hotelesMax
    end
    
    def getHotelesMax
      self.class.HotelesMax
    end
    
    def self.getCasasPorHotel
      @@casasPorHotel
    end
    
    def self.getPrecioLibertad
      @@precioLibertad
    end
    
    attr_reader :encarcelado, :nombre, :numCasillaActual, :saldo, :encarcelado, :puedeComprar, :propiedades, :salvoconducto
    attr_writer :saldo, :numCasillaActual
    
    def cancelarHipoteca(ip)
      result = false
      if (!@encarcelado && existeLaPropiedad(ip) && puedoGastar(@propiedades[ip].getImporteCancelarHipoteca))
        result = @propiedades[ip].cancelarHipoteca(self)
        Diario.instance.ocurre_evento("El jugador #{@nombre} cancela la hipoteca de la propiedad #{ip}")
      end
    end
    
    def cantidadCasasHoteles
      suma = 0
      for i in 0..@propiedades.size-1
        suma = suma + @propiedades[i].cantidadCasasHoteles
      end
      
      return suma
    end
    
    def <=>(jugador)
      @saldo <=> jugador.saldo
    end
    
    def comprar(titulo)
      result = false
      if (!@encarcelado && @puedeComprar && puedoGastar(titulo.precioCompra))
        @propiedades << titulo
        Diario.instance.ocurre_evento("El jugador #{@nombre} compra la propiedad #{titulo.nombre}")
        @puedeComprar = false
        result = titulo.comprar(self)
      end
    end
    
    def construirCasa(ip)
      result = false
      propiedad = @propiedades[ip]
      if (!@encarcelado && existeLaPropiedad(ip) && puedoEdificarCasa(propiedad))
        result = propiedad.construirCasa(self)
      end
    end
    
    def construirHotel(ip)
      result = false
      propiedad = @propiedades[ip]
      if (!@encarcelado && existeLaPropiedad(ip) && puedoEdificarHotel(propiedad))
        propiedad.derruirCasas(@@casasPorHotel, self)
        Diario.instance.ocurre_evento("El jugador #{@nombre} construye hotel en la propiedad #{ip}")
        result = propiedad.construirHotel(self)
      end
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
      @saldo = @saldo + @@pasoPorSalida
    end
    
    def hipotecar(ip)
      result = false
      if (!@encarcelado && existeLaPropiedad(ip))
        @propiedades[ip].hipotecar(self)
        Diario.instance.ocurre_evento("El jugador #{@nombre} hipoteca la propiedad #{ip}")
        result = true
      end
    end
    
    def modificarSaldo(cantidad)
      @saldo = @saldo + cantidad
      Diario.instance.ocurre_evento("Se le suma #{cantidad} al saldo del jugador #{@nombre}")
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
      modificarSaldo(@@pasoPorSalida)
      Diario.instance.ocurre_evento("El jugador #{@nombre} ha pasado por la salida")
      return true
    end
    
    def perderSalvoconducto
      @salvoconducto.usada
      @salvoconducto = nil
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
      
      if puedoGastar(@@precioLibertad)
        puede = true
      end
    end
    
    def puedoEdificarCasa(propiedad)
      puedo = false
      if propiedad.numCasas < getCasasMax && puedoGastar(propiedad.precioEdificar)
        puedo = true        
      end
    end
    
    def puedoEdificarHotel(propiedad)
      puedo = false
      if propiedad.numHoteles < getHotelesMax && propiedad.numCasas >= @@casasPorHotel && puedoGastar(propiedad.precioEdificar)
        puedo = true
      end
    end
    
    def puedoGastar(precio)
      puedo = false
      
      if (@saldo >= precio)
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
        paga(@@precioLibertad)
        @encarcelado = false
        Diario.instance.ocurre_evento("El jugador #{@nombre} paga #{@@precioLibertad} para salir de la carcel")
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
    
    def tiene_algo_que_gestionar
      tienePropiedades = false
      
      if @propiedades.size > 0
        tienePropiedades = true
      end
    end
    
    def tieneSalvoconducto
      tiene = false
      
      if @salvoconducto != nil
        tiene = true
      end
    end
    
    def toString
      if (@salvoconducto == nil)
        salvoconducto = false
      else
        salvoconducto = true
      end
      info = "Jugador #{@nombre} en la casilla #{@numCasillaActual} con saldo #{@saldo}. Salvoconducto? #{salvoconducto},
              Puede comprar? #{@puedeComprar}, Encarcelado? #{@encarcelado}\n"
    end
    
    def vender(ip)
      resultado = false
      
      if !@encarcelado && existeLaPropiedad(ip)
        @propiedades[ip].vender(self)  
        @propiedades.delete_at(ip)
        Diario.instance.ocurre_evento("El jugador #{@nombre} ha vendido una propiedad")
        resultado = true
      end
      
      return resultado      
    end
    
    def propiedadesToString
      prop = Array.new
      for i in 0..@propiedades.length-1
        prop << @propiedades[i].toString
      end
      return prop
    end
    
    def aniadePropiedad(titulo)
      @propiedades.push(titulo)
    end
    
    protected :debeSerEncarcelado
    
    private :getHotelesMax, :existeLaPropiedad, :getPremioPasoSalida, :perderSalvoconducto, :puedeSalirCarcelPagando, :puedoEdificarCasa, :puedoEdificarHotel, :puedoGastar
    private_class_method :getPrecioLibertad
  end
end
