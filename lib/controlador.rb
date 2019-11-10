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
          operacion = @juego.siguientePaso
          if (operacion != Operaciones_juego::PASAR_TURNO)
            @vista.mostrarEventos
          end
          final = @juego.finalDelJuego
          if (!final && operacion == Operaciones_juego::COMPRAR)
            if (@vista.comprar == 0)
              @juego.comprar
            end
            
            @juego.siguientePasoCompletado(operacion)
           
          elsif (!final && operacion == Operaciones_juego::GESTIONAR)
            @vista.gestionar
            op = OperacionInmobiliaria.new(Lista_Gestiones_Enum[@vista.iGestion], @vista.iPropiedad)
            if (op.gestion == GestionesInmobiliarias::VENDER)
              @juego.vender(op.numPropiedad)
            elsif (op.gestion == GestionesInmobiliarias::HIPOTECAR)
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
            @juego.siguientePasoCompletado(operacion)
          end
        end
        @juego.mostrarRanking
    end
  end
end
