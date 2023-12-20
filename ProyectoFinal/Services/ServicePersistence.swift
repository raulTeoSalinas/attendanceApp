//
//  ServicePersistence.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

/// `ServicePersistence` es una clase que encapsula la capa de persistencia utilizada por el servicio.
class ServicePersistence {
    
    /// La capa de persistencia utilizada por el servicio.
    var persistence: Persistence
    
    /// Inicializa una nueva instancia de `ServicePersistence`.
    init() {
         persistence = PersistenceImpl()
    }
}
