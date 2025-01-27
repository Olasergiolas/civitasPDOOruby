# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Civitas
    module GestionesInmobiliarias
      VENDER = :vender
      HIPOTECAR = :hipotecar
      CANCELAR_HIPOTECA = :cancelar_hipoteca
      CONSTRUIR_CASA = :construir_casa
      CONSTRUIR_HOTEL = :construir_hotel
      TERMINAR = :terminar
    end
    
    Lista_Gestiones = ["Vender", "Hipotecar", "CancelarHipoteca",
      "ConstruirCasa", "ConstruirHotel", "Terminar"]
    
    Lista_Gestiones_Enum = [GestionesInmobiliarias::VENDER, GestionesInmobiliarias::HIPOTECAR, 
      GestionesInmobiliarias::CANCELAR_HIPOTECA, GestionesInmobiliarias::CONSTRUIR_CASA, GestionesInmobiliarias::CONSTRUIR_HOTEL,
      GestionesInmobiliarias::TERMINAR]
end
