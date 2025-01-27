# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: UTF-8

require 'singleton'
require_relative 'Diario'

module Civitas
    class Dado
    include Singleton
    
      @@SalidaCarcel = 5
      def initializate
        @random = 0
        @ultimoResultado = 0
        @debug = false
      end
      
      def tirar
        if @debug == false
          @random = 1 + rand(6)
          @ultimoResultado = @random
        else
          @random = 1
          @ultimoResultado = @random
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
          Diario.instance.ocurre_evento("Modo debug Dado activado.")
        elsif d == false
          Diario.instance.ocurre_evento("Modo debug Dado desactivado.")
        else
          @debug = false
        end
      end
      
      attr_reader :ultimoResultado
      
    end
end
