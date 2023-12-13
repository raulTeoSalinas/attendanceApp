//
//  ServicePersistence.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

class ServicePersistence {
    
    var persistence: Persistence
    
    init() {
         persistence = PersistenceImpl()
    }
}
