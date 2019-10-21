# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'GestionesInmobiliarias'

module Civitas
    class OperacionInmobiliaria
      def initalize(gest, ip)
        @numPropiedad = ip
        @gestion = gest
      end
      
      attr_reader :numPropiedad, :gestion
    end
end
