//
//  Grupo.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/11/23.
//

import Foundation
import GRDB
struct Grupo: Codable, Identifiable, FetchableRecord, PersistableRecord {
    var id: String
    var materia: String
    var carrera: String
    
    mutating func updateObject(object: Grupo) {
        self.id = object.id
        self.materia = object.materia
        self.carrera = object.carrera
    }
    

    
}
