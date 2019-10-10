# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

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
        @texto
        @valor
        @tipo = tipo
        @mazo
        @tablero = tablero
      end
      
      def self.new_tp_tb_tx(tipo, tablero, texto)
        @texto = texto
        @valor
        @tipo = tipo
        @mazo
        @tablero = tablero
      end
      
      def self.new_tp_tx(tipo, texto)
        @texto = texto
        @valor
        @tipo = tipo
        @mazo
        @tablero
      end
      
      def self.new_tp_m(tipo, mazo)
        @texto
        @valor
        @tipo = tipo
        @mazo = mazo
        @tablero
      end
      
      def aplicarAJugador(actual, todos)
        
      end
      
      def jugadorCorrecto(actual, todos)
        
      end
      
      def salirDelMazo
        
      end
      
      def toString
        
      end
      
      def usada
        
      end
      
      private
      
      def aplicarAJugador_irACasilla(actual, todos)
        
      end
      
      def aplicarAJugador_irCarcel(actual, todos)
        
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
        
      end
      
      def init
        
      end
      
      
    end
end
