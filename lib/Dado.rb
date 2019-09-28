# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require 'singleton'
module Civitas
    class Dado
    include Singleton
      def initializate
        @random
        @ultimoResultado
        @debug = false
        @SalidaCarcel
      end
      
      def tirar
        if @debug == false
          @random = 1 + rand(6)
        else
          @random = 1
        end
      end
      
      def salgoDeLaCarcel
        sale = false
        if tirar >= 5
          sale = true
        end
      end
      
      def quienEmpieza(n)
        empieza = rand(n)
      end
      
      def setDebug(d)
        @debug = d
        if d == true
          Diario.ocurre_evento("Modo debug Dado activado.")
        elsif d == false
          Diario.ocurre_evento("Modo debug Dado desactivado.")
        else
          @debug = false
        end
      end
      
      att_reader :ultimoResultado
    end
end
