# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'TituloPropiedad'

module Civitas
  class JugadorEspeculador < Jugador
    
    @FactorEspeculador = 2
    @CasasMax = Jugador.CasasMax * @FactorEspeculador
    
    def initialize(jugador, fianza)
      super(jugador.nombre)
      @propiedades = jugador.propiedades
      @Fianza = fianza
      JugadorEspeculador.nuevoEspeculador(self)
    end
    
    def self.nuevoEspeculador(jugador)
      
      for i in 0..jugador.propiedades.size - 1
        jugador.propiedades[i].acutalizaPropietarioPorConversion(jugador)
      end
      
    end
  end
end
