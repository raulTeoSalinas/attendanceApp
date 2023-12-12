//
//  AlumnoGrupo.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/12/23.
//

import Foundation
import GRDB

struct AlumnoGrupo: Codable, Identifiable, FetchableRecord, PersistableRecord {
    var id: Int64?
    var idAlumno: String
    var idGrupo: String
    
    mutating func updateObject(object: AlumnoGrupo) {
        self.id = object.id
        self.idAlumno = object.idAlumno
        self.idGrupo = object.idGrupo
    }
}
