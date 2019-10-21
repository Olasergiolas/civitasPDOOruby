# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'gestor_estados'
require_relative 'Jugador'
require_relative 'Dado'
require_relative 'MazoSorpresas'
require_relative 'Tablero'

module Civitas
    class CivitasJuego
      
      def initialize(nombres)
        @indiceJugador = Dado.instance.quienEmpieza(@jugadores.size)
        @jugadores = Array.new
        for i in 1..nombres.size
          jugadores.push(Jugador.new(nombres[i]))
        end
        
        @mazo = MazoSorpresas.new
        @tablero = Tablero.new(5)
        @estado = @gestorEstados.estado_inicial
        @gestorEstados = Gestor_estados.new
        inicializarTablero(@mazo)
        inicializarMazoSorpresas(@tablero)
      end
      
      def cancelarHipoteca(ip)
        @jugadores[@indiceJugador].cancelarHipoteca(ip)
      end
      
      def comprar
        
      end
      
      def construirCasa(ip)
        @jugadores[@indiceJugador].construirCasa(ip)
      end
      
      def construirHotel(ip)
        @jugadores[@indiceJugador].construirHotel(ip)
      end
      
      def finalDelJuego
        terminar = false
        for i in 1..@jugadores.size
          if @jugadores[i].enBancarrota
            terminar = true
          end
        end
        
        return terminar
      end
      
      def getCasillaActual
        @tablero.getCasilla(getJugadorActual.numCasillaActual)
      end
      
      def getJugadorActual
        @jugadores[@indiceJugador]
      end
      
      def hipotecar(ip)
        @jugadores[@indiceJugador].hipotecar(ip)
      end
      
      def infoJugadorTexto
        @jugadores[@indiceJugador].toString
      end
      
      def salirCarcelPagando
        @jugadores[@indiceJugador].salirCarcelPagando(ip)
      end
      
      def salirCarcelTirando
        @jugadores[@indiceJugador].salirCarcelTirando(ip)
      end
      
      def siguientePaso
        
      end
      
      def siguientePasoCompletado(operacion)
        @estado = @gestorEstados.siguiente_estado(@jugadores[@indiceJugador], estado, operacion)      #Qué estado entra aquí?
      end
      
      def vender(ip)
        @jugadores[@indiceJugador].vender(ip)
      end
      
      private
      
      def avanzaJugador
        
      end
      
      def contabilizarPasosPorSalida(jugadorActual)
        while @tablero.getPorSalida > 0
          jugadorActual.pasaPorSalida
        end
      end
      
      def inicialiarMazoSorpresas(tablero)
        
        s1 = Sorpresa.new_tp_tb(TipoSorpresa::IRCARCEL, tablero)
        s2 = Sorpresa.new_tp_m(TipoSorpresa::SALIRCARCEL, @mazo)
        s3 = Sorpresa.new_tp_tx(TipoSorpresa::PORCASAHOTEL, "A pagar todos")
        
        @mazo.alMazo(s1)
        @mazo.alMazo(s2)
        @mazo.alMazo(s3)
      end
      
      def inicializarTablero(mazo)
        
        c1 = Casilla.new_num_n(@tablero.numCasillaCarcel, "Carcel")
        c2 = Casilla.new_m_n(mazo, "Bowsy")
        c3 = Casilla.new_c_n(1000, "Hacienda")
        
        @tablero.aniadeCasilla(c1)
        @tablero.aniadeCasilla(c2)
        @tablero.aniadeCasilla(c3)
      end
      
      def pasarTurno
        if @indiceJugador < @jugadores.size - 1               #Ya que el índice empieza desde 0
          @indiceJugador = @indiceJugador + 1
        
        else
          @indiceJugador = 0
        end
      end
      
      def ranking
        @ranking = Array.new(@jugadores)
        @ranking.sort
        @ranking
      end
    end
end
