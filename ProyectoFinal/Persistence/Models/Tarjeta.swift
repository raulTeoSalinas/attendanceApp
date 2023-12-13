//
//  Tarjeta.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import Foundation
import GRDB

struct Tarjeta: Codable, Identifiable {
    var id: String
    
    init(id: String) {
        self.id = id
    }
}

extension Tarjeta: FetchableRecord, PersistableRecord {}

