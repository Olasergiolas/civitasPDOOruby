#encoding:utf-8

require_relative 'Dado'
require_relative 'MazoSorpresas'
require_relative 'Sorpresa'
require_relative 'Casilla'
require_relative 'Diario'
require_relative 'Jugador'
require_relative 'TipoSorpresa'
require_relative 'vista_textual'
require_relative 'civitas_juego'
require_relative 'controlador'

module Civitas
  class JuegoTexto
    def self.main
      vista = Vista_textual.new
      juego = CivitasJuego.new(["Paloma", "Búho", "Ganso", "Pato"])
      Dado.instance.setDebug(true)
      controlador = Controlador.new
      Controlador.juega
    end
  end
  
  JuegoTexto.main
    
end
