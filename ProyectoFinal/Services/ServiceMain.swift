//
//  ServiceMain.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation


class ServiceMain: ObservableObject {
    
    var persistence: ServicePersistence
    var serviceVm: ServiceViewModels
    
    init() {
        persistence = ServicePersistence()
        serviceVm = ServiceViewModels(servicePersistence: persistence)
    }
}
