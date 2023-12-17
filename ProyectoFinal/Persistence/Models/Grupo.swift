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
    
}

extension Grupo: FetchableRecord, PersistableRecord { }
