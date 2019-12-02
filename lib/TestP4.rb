# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'Jugador'
require_relative 'JugadorEspeculador'
require_relative 'TituloPropiedad'

module Civitas
  class TestP4
    def main
      j1 = Jugador.new("Ines")
      
      
      titulo1 = TituloPropiedad.new("Alcala",200,10,150,600,300)
      j1.aniadePropiedad(titulo1)
      puts j1.inspect
      
      j1Esp = JugadorEspeculador.new(j1, 200)
      puts j1Esp.inspect
    end
  end
  
  prueba = TestP4.new
  prueba.main
end
