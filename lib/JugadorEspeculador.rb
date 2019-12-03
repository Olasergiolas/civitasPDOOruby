# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'TituloPropiedad'

module Civitas
  class JugadorEspeculador < Jugador
    
    @FactorEspeculador = 2
    @CasasMax = Jugador.CasasMax * @FactorEspeculador
    
    def initialize(fianza)
      @Fianza = fianza
    end
    
    attr_accessor :fianza
    
    def self.nuevoEspeculador(jugador, fianza)
      jEsp = new(fianza)
      jEsp.desde(jugador)
      
      for i in 0..jEsp.propiedades.size - 1
        jEsp.propiedades[i].acutalizaPropietarioPorConversion(jEsp)
      end
      
      jEsp
    end
    
    def toString
      if (@salvoconducto == nil)
        salvoconducto = false
      else
        salvoconducto = true
      end
      info = "Jugador Especulador #{@nombre} en la casilla #{@numCasillaActual} con saldo #{@saldo}. Salvoconducto? #{salvoconducto},
              Puede comprar? #{@puedeComprar}, Encarcelado? #{@encarcelado}, con fianza #{@Fianza}\n"
    end
  end
end
