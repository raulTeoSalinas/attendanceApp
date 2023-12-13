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
    var idTarjeta: String


    mutating func updateObject(object: Alumno) {
        self.id = object.id
        self.name = object.name
        self.lastname1 = object.lastname1
        self.lastname2 = object.lastname2
        self.academicId = object.academicId
        self.idTarjeta = object.idTarjeta
    }
    
}
