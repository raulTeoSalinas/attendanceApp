//
//  Alumno.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

/// Ese es nuestro modelo Alumno, para poder ser usado por GRDB y en nuestro ``AlumnoDAO``.
struct Alumno: Codable, Identifiable {
    var id: Int64?
    var name: String
    var lastname1: String
    var lastname2: String
    var academicId: String
    var idTarjeta: String
    var idGrupo: Int64?
    
    init(id: Int64? = nil, name: String, lastname1: String, lastname2: String, academicId: String, idTarjeta: String, idGrupo: Int64? = nil) {
        self.id = id
        self.name = name
        self.lastname1 = lastname1
        self.lastname2 = lastname2
        self.academicId = academicId
        self.idTarjeta = idTarjeta
        self.idGrupo = idGrupo
    }
}

// GRDB
extension Alumno: FetchableRecord, PersistableRecord { }
