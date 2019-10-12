# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require './gestor_estados'
require './Jugador'
require './Dado'
require './MazoSorpresas'
require './Tablero'

module Civitas
    class CivitasJuego
      
      def initialize(nombres)
        @indiceJugador = Dado.instance.quienEmpieza(@jugadores.size)
        @jugadores = Array.new
        for i in 1..nombres.size
          jugadores.push(Jugador.new(nombres[i]))
        end
        
        @mazo = MazoSorpresas.new
        @tablero
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
        
      end
      
      def getJugadorActual
        
      end
      
      def hipotecar(ip)
        @jugadores[@indiceJugador].hipotecar(ip)
      end
      
      def infoJugadorTexto
        
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
        #No entiendo lo que tengo que hacer
      end
      
      def inicializarTablero(mazo)
        #No entiendo lo que tengo que hacer
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
