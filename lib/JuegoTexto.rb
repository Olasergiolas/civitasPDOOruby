# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

# encoding: UTF-8

require_relative 'Dado'
require_relative 'MazoSorpresas'
require_relative 'Sorpresa'
require_relative 'Casilla'
require_relative 'Diario'
require_relative 'Jugador'
require_relative 'TipoSorpresa'
require_relative 'VistaTextual'
require_relative 'civitas_juego'
require_relative 'controlador'

module Civitas
  class JuegoTexto
    
    def initialize
      @d = Dado.instance         
      @repeticiones = [0, 0, 0, 0]
      @mazo = MazoSorpresas.new
      @diario = Diario.instance
      @tablero = Tablero.new(5)
    end

    def main
      #Primer Apartado
      for a in 1..100 do
        resultado = @d.quienEmpieza(4)
        @repeticiones[resultado] = @repeticiones[resultado] + 1
      end

      print @repeticiones
      puts " "

      #Segundo Apartado:
      @d.setDebug(true)
      puts "Tiradas con Debug activado: "
      for a in 1..10 do
        @d.tirar
        puts @d.ultimoResultado
      end

      @d.setDebug(false)
      puts "Tiradas con Debug desactivado: "
      for a in 1..10 do
        @d.tirar
        puts @d.ultimoResultado
      end


      #Tercer Apartado
      puts "Test salgoDeLaCarcel: "
      if (@d.salgoDeLaCarcel == true)
        puts @d.ultimoResultado
        puts "Salgo de la carcel"

      else
        puts @d.ultimoResultado
        puts "No salgo de la carcel"
      end

      #Quinto Apartado
      s1 = Sorpresa.new_tp_tx(TipoSorpresa::IRCASILLA, 'Hola')
      s2 = Sorpresa.new_tp_tx(TipoSorpresa::IRCASILLA, 'Hola')
      c = Casilla.new_t(@titulo)
      j1 = Jugador.new('SERGIO')

      @mazo.alMazo(s1)
      @mazo.alMazo(s2)
      @mazo.siguiente
      @mazo.inhabilitarCartaEspecial(s2)
      @mazo.habilitarCartaEspecial(s2)
      
      #Sexto Apartado
      puts @diario.leer_evento
      puts @diario.eventos_pendientes
      
      #Pruebas
      
    end
  end
  
  personaje = JuegoTexto.new
  personaje.main
    
end
