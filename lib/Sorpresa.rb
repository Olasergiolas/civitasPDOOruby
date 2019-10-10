# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require './Diario'
require './TipoSorpresa'
require './Jugador'
require './Dado'
require './Tablero'
require './Casilla'

module Civitas
    class Sorpresa
      def initialize
        @texto
        @valor
        @tipo
        @mazo
        @tablero
      end
      
      def self.new_tp_tb(tipo, tablero)
        init
        @texto
        @valor
        @tipo = tipo
        @mazo
        @tablero = tablero
      end
      
      def self.new_tp_tb_tx(tipo, tablero, texto)
        init
        @texto = texto
        @valor
        @tipo = tipo
        @mazo
        @tablero = tablero
      end
      
      def self.new_tp_tx(tipo, texto)
        init
        @texto = texto
        @valor
        @tipo = tipo
        @mazo
        @tablero
      end
      
      def self.new_tp_m(tipo, mazo)
        init
        @texto
        @valor
        @tipo = tipo
        @mazo = mazo
        @tablero
      end
      
      def aplicarAJugador(actual, todos)
        if @tipo == TipoSorpresa::IRCASILLA
          aplicarAJugador_irACasilla(actual, todos)
          
        elsif @tipo == TipoSorpresa::IRCARCEL
          aplicarAJugador_irCarcel(actual, todos)  
          
        elsif @tipo == TipoSorpresa::PAGARCOBRAR
          aplicarAJugador_pagarCobrar(actual, todos)  
          
        elsif @tipo == TipoSorpresa::SALIRCARCEL
          aplicarAJugador_salirCarcel(actual, todos)  
          
        elsif @tipo == TipoSorpresa::PORCASAHOTEL
          aplicarAJugador_porCasaHotel(actual, todos)  
          
        else @tipo == TipoSorpresa::PORJUGADOR
          aplicarAJugador_porJugador(actual, todos)  
        end
      end
      
      def jugadorCorrecto(actual, todos)
        correcto = false
        if (actual >= 0 && actual <= todos.length)
          correcto = true
        end
        
        return correcto
      end
      
      def salirDelMazo
        
      end
      
      def toString
        
      end
      
      def usada
        
      end
      
      private
      
      def aplicarAJugador_irACasilla(actual, todos)
        if (jugadorCorrecto == true)
          informe(actual, todos)
          casillajug = todos[actual].numCasillaActual
          tirada = @tablero.calcularTirada(casillajug, @valor)
          npos = todos[actual].nuevaPosicion(casillajug, tirada)
          todos[actual].moverACasilla(npos)
          @tablero.getCasilla(@valor).recibeJugador(actual, todos)
          
        end
      end
      
      def aplicarAJugador_irCarcel(actual, todos)
        if jugadorCorrecto(actual, todos) == true
          informe(actual, todos)
          jugador.encarcelar(@tablero.numCasillaCarcel)
        end
      end
      
      def aplicarAJugador_pagarCobrar(actual, todos)
        
      end
      
      def aplicarAJugador_porCasaHotel(actual, todos)
        
      end
      
      def aplicarAJugador_porJugador(actual, todos)
        
      end
      
      def aplicarAJugador_salirCarcel(actual, todos)
        
      end
      
      def informe(actual, todos)
        Diario.instance.ocurre_evento('Aplicando sorpresa al jugador #{todos[actual].nombre}')
      end
      
      def init
        @valor = -1
        @mazo = 0
        @tablero = 0
      end
      
      
    end
end
