//
//  Tarjeta.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import Foundation
import GRDB

/// Ese es nuestro modelo Tarjeta, para poder ser usado por GRDB y en nuestro ``TarjetaDAO``.
struct Tarjeta: Codable, Identifiable {
    var id: String
    
    init(id: String) {
        self.id = id
    }
}

extension Tarjeta: FetchableRecord, PersistableRecord {}

