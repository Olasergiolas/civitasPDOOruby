# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

# encoding: UTF-8

require './Dado'
require './MazoSorpresas'
require './Sorpresa'
require './Casilla'
require './Diario'
require './Jugador'

module Civitas
  class TestP1

    def main
      #Primer Apartado

      @D = Dado.instance         
      @repeticiones = [0, 0, 0, 0]
      @mazo = MazoSorpresas.new
      @Diario = Diario.instance

      for a in 1..100 do
        resultado = @D.quienEmpieza(4)
        @repeticiones[resultado] = @repeticiones[resultado] + 1
      end

      print @repeticiones
      puts " "

      #Segundo Apartado:
      @D.setDebug(true)
      puts "Tiradas con Debug activado: "
      for a in 1..10 do
        @D.tirar
        puts @D.ultimoResultado
      end

      @D.setDebug(false)
      puts "Tiradas con Debug desactivado: "
      for a in 1..10 do
        @D.tirar
        puts @D.ultimoResultado
      end


      #Tercer Apartado
      puts "Test salgoDeLaCarcel: "
      if (@D.salgoDeLaCarcel == true)
        puts @D.ultimoResultado
        puts "Salgo de la carcel"

      else
        puts @D.ultimoResultado
        puts "No salgo de la carcel"
      end

      #Quinto Apartado
      s1 = Sorpresa.new
      s2 = Sorpresa.new

      @mazo.alMazo(s1)
      @mazo.alMazo(s2)
      @mazo.siguiente
      @mazo.inhabilitarCartaEspecial(s2)
      @mazo.habilitarCartaEspecial(s2)
      
      #Sexto Apartado
      puts @Diario.leer_evento
      puts @Diario.eventos_pendientes
    end
  end
  
  personaje = TestP1.new
  personaje.main
    
end
