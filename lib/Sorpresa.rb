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
      def initialize(t, v, tip, m, tab)
        @texto = t
        @valor = v
        @tipo = tip
        @mazo = m
        @tablero = tab
      end
      
      def self.new_tp_tb(tipo, tablero)
        new(nil, 0, tipo, nil, tablero)
      end
      
      def self.new_tp_tb_v_tx(tipo, tablero, valor, texto)
        new(texto, valor, tipo, nil, tablero)
      end
      
      def self.new_tp_tx(tipo, texto)
        new(texto, 0, tipo, nil, nil)
      end
      
      def self.new_tp_v(tipo, valor)
        new(" ", valor, tipo, nil, nil)
      end
      
      def self.new_tp_m(tipo, mazo)
        new(nil, 0, tipo, mazo, nil)
      end
      
      def aplicarAJugador(actual, todos)
        correcto = jugadorCorrecto(actual, todos)
        if (correcto)
          informe(actual, todos)
        end
        if @tipo == TipoSorpresa::IRCASILLA && correcto
          aplicarAJugador_irACasilla(actual, todos)
          
        elsif @tipo == TipoSorpresa::IRCARCEL && correcto
          aplicarAJugador_irCarcel(actual, todos)  
          
        elsif @tipo == TipoSorpresa::PAGARCOBRAR && correcto
          aplicarAJugador_pagarCobrar(actual, todos)  
          
        elsif @tipo == TipoSorpresa::SALIRCARCEL && correcto
          aplicarAJugador_salirCarcel(actual, todos)  
          
        elsif @tipo == TipoSorpresa::PORCASAHOTEL && correcto
          aplicarAJugador_porCasaHotel(actual, todos)  
          
        else @tipo == TipoSorpresa::PORJUGADOR && correcto
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
        casillajug = todos[actual].numCasillaActual
        tirada = @tablero.calcularTirada(casillajug, @valor)
        npos = @tablero.nuevaPosicion(casillajug, tirada)
        todos[actual].moverACasilla(npos)
        @tablero.getCasilla(@valor).recibeJugador(actual, todos)
      end
      
      def aplicarAJugador_irCarcel(actual, todos)
        todos[actual].encarcelar(@tablero.numCasillaCarcel)
      end
      
      def aplicarAJugador_pagarCobrar(actual, todos)
        todos[actual].modificarSaldo(@valor)
      end
      
      def aplicarAJugador_porCasaHotel(actual, todos)
        todos[actual].modificarSaldo(@valor * (todos[actual].cantidadCasasHoteles))
      end
      
      def aplicarAJugador_porJugador(actual, todos)
        cobrar = Sorpresa.new_tp_v(TipoSorpresa::PAGARCOBRAR, @valor*(todos.size-1))
        pagar = Sorpresa.new_tp_v(TipoSorpresa::PAGARCOBRAR, @valor*-1)    

        for i in 0..todos.size-1
          if (i != actual)
            pagar.aplicarAJugador(i, todos)

          else
            cobrar.aplicarAJugador(i, todos)
          end
        end
      end
      
      def aplicarAJugador_salirCarcel(actual, todos)
        loTienen = false
        for i in 0..todos.size-1                              #Debería usar un break?
          if todos[i].tieneSalvoconducto
            loTienen = true
          end
        end

        if !loTienen
          todos[actual].obtenerSalvoconducto(self)
          salirDelMazo
        end
      end
      
      def informe(actual, todos)
        Diario.instance.ocurre_evento("Aplicando sorpresa al jugador #{todos[actual].nombre}")
      end
      
      private_class_method :new
    end
end
