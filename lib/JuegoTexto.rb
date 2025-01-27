#encoding:utf-8

require_relative 'Dado'
require_relative 'vista_textual'
require_relative 'civitas_juego'
require_relative 'controlador'

module JuegoTexto
  class JuegoTexto
    def self.main
      vista = Vista_textual.new
      juego = Civitas::CivitasJuego.new(["Paloma", "Búho", "Ganso", "Pato"])
      Civitas::Dado.instance.setDebug(true)
      controlador = Controlador.new(juego, vista)
      controlador.juega
    end
  end
  
  JuegoTexto.main
    
end
