# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'TituloPropiedad'

module Civitas
  class JugadorEspeculador < Jugador
    
    @FactorEspeculador = 2
    @CasasMax = Jugador.CasasMax * @FactorEspeculador
    @HotelesMax = Jugador.HotelesMax * @FactorEspeculador
    
    def initialize(fianza)
      @fianza = fianza
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
      info = "Especulador, " + super
    end
    
    def debeSerEncarcelado
      debeSerlo = super
      
      if (debeSerlo && @saldo > @fianza)
        puts "El jugador especulador paga la fianza y evita entrar en la carcel"
        paga(@fianza)
        debeSerlo = false
      end
    end
    
    def pagaImpuesto(cantidad)
      cantidadEsp = cantidad/2
      super(cantidadEsp)
    end
  end
end
