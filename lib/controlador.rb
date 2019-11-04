# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module JuegoTexto
    class Controlador
      include Civitas
      def initialize(juego, vista)
        @juego = juego
        @vista = vista
      end
      
      def juega
        @vista.setCivitasJuego(@juego)
        while (!@juego.finalDelJuego)
          @vista.actualizarVista
          @vista.pausa
          operacion = @vista.mostrarSiguienteOperacion(@juego.siguientePaso)
          if (operacion != Operaciones_juego::PASAR_TURNO)
            @vista.mostrarEventos
          end
          final = @juego.finalDelJuego
          if (!final && operacion == Operaciones_juego::COMPRAR && @vista.comprar == 0)
            @juego.comprar
            @juego.siguientePasoCompletado(operacion)
            
          elsif (!final && operacion == Operaciones_juego::GESTIONAR)
            @vista.gestionar
            op = OperacionInmobilaria.new(@vista.iGestion, @vista.iPropiedad)
            if (op.gestion == GestionesInmobiliarias::VENDER)
              @juego.vender(op.numPropiedad)
            elsif (op.gestion == GestionesInmobiliaras::HIPOTECAR)
              @juego.hipotecar(op.numPropiedad)
            elsif (op.gestion == GestionesInmobiliarias::CANCELAR_HIPOTECA)
              @juego.cancelarHipoteca(op.numPropiedad)
            elsif (op.gestion == GestionesInmobiliarias::CONSTRUIR_CASA)
              @juego.construirCasa(op.numPropiedad)
            elsif (op.gestion == GestionesInmobiliarias::CONSTRUIR_HOTEL)
              @juego.construirHotel(op.numPropiedad)
            elsif (op.gestion == GestionesInmobiliarias::TERMINAR)
              @juego.siguientePasoCompletado(operacion)
            end
            
          elsif (!final && operacion == Operaciones_juego::SALIR_CARCEL)
            if (@vista.salirCarcel == 0)
              @juego.salirCarcelPagando
            else
              @juego.salirCarcelTirando
            end
          end
        end
        for i in 0..3
          @juego.ranking.toString
        end
      end
    end
end
