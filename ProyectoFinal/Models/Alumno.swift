//
//  Alumno.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

struct Alumno: Codable, Identifiable, FetchableRecord, PersistableRecord {
    var id: String
    var name: String
    var lastname1: String
    var lastname2: String
    var academicId: String
    
    mutating func updateName(name: String) {
        self.name = name
    }
}
