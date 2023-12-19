//
//  ServiceViewModels.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class ServiceViewModels {
    
    var servicePersistence: ServicePersistence
    var mainViewModel: MainViewModel

    
    init(servicePersistence: ServicePersistence) {
        self.servicePersistence = servicePersistence
        
        let alumnoViewModel = AlumnoViewModel(alumnosDAO: AlumnoDAO(persistence: servicePersistence.persistence))
        let grupoViewModel = GrupoViewModel(grupoDAO: GrupoDAO(persistence: servicePersistence.persistence))
        let tarjetaViewModel = TarjetaViewModel(tarjetaDAO: TarjetaDAO(persistence: servicePersistence.persistence))
        let asistenciaViewModel = AsistenciaViewModel(asistenciaDAO: AsistenciaDAO(persistence: servicePersistence.persistence))
        mainViewModel = MainViewModel(alumnoViewmodel: alumnoViewModel, tarjetaViewmodel: tarjetaViewModel, grupoViewmodel: grupoViewModel, asistenciaViewmodel: asistenciaViewModel)
        
    }
}
