//
//  ServiceViewModels.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class ServiceViewModels {
    
    var servicePersistence: ServicePersistence
    var alumnoViewModel: AlumnoViewModel
    var grupoViewModel: GrupoViewModel
    var tarjetaViewModel: TarjetaViewModel
    var asistenciaViewModel: AsistenciaViewModel
    
    init(servicePersistence: ServicePersistence) {
        self.servicePersistence = servicePersistence
        
        alumnoViewModel = AlumnoViewModel(alumnosDAO: AlumnoDAO(persistence: servicePersistence.persistence))
        grupoViewModel = GrupoViewModel(grupoDAO: GrupoDAO(persistence: servicePersistence.persistence))
        tarjetaViewModel = TarjetaViewModel(tarjetaDAO: TarjetaDAO(persistence: servicePersistence.persistence))
        asistenciaViewModel = AsistenciaViewModel(asistenciaDAO: AsistenciaDAO(persistence: servicePersistence.persistence))
        
    }
}
