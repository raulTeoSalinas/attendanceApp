//
//  ServiceMain.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation


/// Esta es la declaracion de nuestro Servicio principal. Aqui creamos nuestro servicio ``ServicePersistence`` y nuestro ``ServiceViewModels``
class ServiceMain: ObservableObject {
    
    var persistence: ServicePersistence
    var serviceVm: ServiceViewModels
    
    init() {
        persistence = ServicePersistence()
        serviceVm = ServiceViewModels(servicePersistence: persistence)
    }
}
