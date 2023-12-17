//
//  ServiceViewModels.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class ServiceViewModels {
    
    var servicePersistence: ServicePersistence
    var viewModel: ViewModel
    
    init(servicePersistence: ServicePersistence) {
        self.servicePersistence = servicePersistence
        
        viewModel = ViewModel(
            alumnosDAO: AlumnoDAO(persistence: servicePersistence.persistence),
            grupoDAO: GrupoDAO(persistence: servicePersistence.persistence),
            tarjetaDAO: TarjetaDAO(persistence: servicePersistence.persistence),
            asistenciaDAO: AsistenciaDAO(persistence: servicePersistence.persistence)
        )
    }
}
