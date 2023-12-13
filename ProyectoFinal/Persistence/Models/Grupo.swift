//
//  Grupo.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import Foundation
import GRDB

struct Grupo: Codable, Identifiable {
    var id: Int64?
    var materia: String
    var carrera: String
    
    init(id: Int64? = nil, materia: String, carrera: String) {
        self.id = id
        self.materia = materia
        self.carrera = carrera
    }
}

extension Grupo: FetchableRecord, PersistableRecord { }
