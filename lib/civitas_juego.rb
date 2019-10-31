# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require_relative 'gestor_estados'
require_relative 'Jugador'
require_relative 'Dado'
require_relative 'MazoSorpresas'
require_relative 'Tablero'
require_relative 'OperacionesJuego'

module Civitas
    class CivitasJuego
      
      def initialize(nombres)
        @indiceJugadorActual = Dado.instance.quienEmpieza(@jugadores.size)
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
        @jugadores[@indiceJugadorActual].cancelarHipoteca(ip)
      end
      
      def comprar
        jugador = @jugadores[@indiceJugadorActual]
        numCasillaActual = jugador.numCasillaActual
        titulo = @tablero.getCasilla(numCasillaActual).tituloPropiedad
        jugador.comprar(titulo)
      end
      
      def construirCasa(ip)
        @jugadores[@indiceJugadorActual].construirCasa(ip)
      end
      
      def construirHotel(ip)
        @jugadores[@indiceJugadorActual].construirHotel(ip)
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
        @jugadores[@indiceJugadorActual]
      end
      
      def hipotecar(ip)
        @jugadores[@indiceJugadorActual].hipotecar(ip)
      end
      
      def infoJugadorTexto
        @jugadores[@indiceJugadorActual].toString
      end
      
      def salirCarcelPagando
        @jugadores[@indiceJugadorActual].salirCarcelPagando(ip)
      end
      
      def salirCarcelTirando
        @jugadores[@indiceJugadorActual].salirCarcelTirando(ip)
      end
      
      def siguientePaso
        jugador = @jugadores[@indiceJugadorActual]
        operacion = @gestor_estados.operacionesPermitidas(jugador,@estado)
        if (operacion == OperacionesJuego::PASAR_TURNO)
          pasarTurno
          siguientePasoCompletado(operacion)
        elsif (operacion == OperacionesJuego::AVANZAR)
          avanzaJugador
          siguientePasoCompletado(operacion)
        end
        return operacion
      end
      
      def siguientePasoCompletado(operacion)
        @estado = @gestorEstados.siguiente_estado(@jugadores[@indiceJugadorActual], @estado, operacion)
      end
      
      def vender(ip)
        @jugadores[@indiceJugadorActual].vender(ip)
      end
      
      private
      
      def avanzaJugador
          jugadorActual = @jugadores[@indiceJugadorActual]
          posicionNueva = @tablero.nuevaPosicion(jugadorActual.numCasillaActual, Dado.instance.tirar)
          contabilizarPasosPorSalida(jugadorActual)
          jugadorActual.moverACasilla(posicionNueva)
          @tablero.getCasilla(posicionNueva).recibeJugador(@indiceJugadorActual, @jugadores)
          contabilizarPasosPorSalida(jugadorActual)
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
        if @indiceJugadorActual < @jugadores.size - 1               #Ya que el índice empieza desde 0
          @indiceJugadorActual += 1
        
        else
          @indiceJugadorActual = 0
        end
      end
      
      def ranking
        @ranking = Array.new(@jugadores)
        @ranking.sort
        @ranking
      end
    end
end
