//
//  Tarjeta.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import Foundation
import GRDB

struct Tarjeta: Codable, Identifiable, FetchableRecord, PersistableRecord {
    var id: String
    
    mutating func updateObject(object: Tarjeta) {
        self.id = object.id
        
    }
}

