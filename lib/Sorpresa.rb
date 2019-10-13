# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require_relative 'Diario'
require_relative 'TipoSorpresa'
require_relative 'Jugador'
require_relative 'Dado'
require_relative 'Tablero'
require_relative 'Casilla'

module Civitas
    class Sorpresa
      def initialize
        @texto = nil
        @valor = 0
        @tipo = nil
        @mazo = nil
        @tablero = nil
      end
      
      def self.new_tp_tb(tipo, tablero)
        init
        @texto = nil
        @valor = 0
        @tipo = tipo
        @mazo = nil
        @tablero = tablero
      end
      
      def self.new_tp_tb_v_tx(tipo, tablero, valor, texto)
        init
        @texto = texto
        @tipo = tipo
        @mazo = nil
        @tablero = tablero
        @valor = valor
      end
      
      def self.new_tp_tx(tipo, texto)
        init
        @texto = texto
        @valor = 0
        @tipo = tipo
        @mazo = nil
        @tablero = nil
      end
      
      def self.new_tp_m(tipo, mazo)
        init
        @texto = nil
        @valor = 0
        @tipo = tipo
        @mazo = mazo
        @tablero = nil
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
        if @tipo == TipoSorpresa::SALIRCARCEL
          @mazo.inhabilitarCartaEspecial(self)
        end
      end
      
      def toString
        @texto
      end
      
      def usada
        if @tipo == TipoSorpresa::SALIRCARCEL
          @mazo.habilitarCartaEspecial(self)
        end
      end
      
      private
      
      def aplicarAJugador_irACasilla(actual, todos)
        if jugadorCorrecto(actual, todos)
          informe(actual, todos)
          casillajug = todos[actual].numCasillaActual
          tirada = @tablero.calcularTirada(casillajug, @valor)
          npos = todos[actual].nuevaPosicion(casillajug, tirada)
          todos[actual].moverACasilla(npos)
          @tablero.getCasilla(@valor).recibeJugador(actual, todos)
        end
      end
      
      def aplicarAJugador_irCarcel(actual, todos)
        if jugadorCorrecto(actual, todos)
          informe(actual, todos)
          jugador.encarcelar(@tablero.numCasillaCarcel)
        end
      end
      
      def aplicarAJugador_pagarCobrar(actual, todos)
        if jugadorCorrecto(actual, todos)
          informe(actual, todos)
          todos[actual].modificarSaldo(@valor)
        end
      end
      
      def aplicarAJugador_porCasaHotel(actual, todos)
        if jugadorCorrecto(actual, todos)
          informe(actual, todos)
          todos[actual].modificarSaldo(@valor * (todos[actual].propiedades.size))
        end
      end
      
      def aplicarAJugador_porJugador(actual, todos)
        if jugadorCorrecto(actual, todos)
          informe(actual, todos)
          cobrar = Sorpresa.new_tp_tx(TipoSorpresa::PAGARCOBRAR, "Recibe dinero")
          pagar = Sorpresa.new_tp_tx(TipoSorpresa::PAGARCOBRAR, "Todos a pagarle")           #¿Cómo le modifico el valor?
          
          for i in 1..todos.size
            if (i != actual)
              pagar.aplicarAJugador(i, todos)
              
            else
              cobrar.aplicarAJugador(i, todos)
            end
          end
        end
      end
      
      def aplicarAJugador_salirCarcel(actual, todos)
        if jugadorCorrecto(actual, todos)
          informe(actual, todos)
          
          loTienen = false
          for i in 1..todos.size                              #Debería usar un break?
            if todos[i].tieneSalvoconducto
              loTienen = true
            end
          end
          
          if !loTienen
            todos[actual].obtenerSalvoconducto(self)
            salirDelMazo
          end
        end
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
