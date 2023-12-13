//
//  Alumno.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

struct Alumno: Codable, Identifiable {
    var id: Int64?
    var name: String
    var lastname1: String
    var lastname2: String
    var academicId: String
    var idTarjeta: String
    var idGrupo: Int64?
}

// GRDB
extension Alumno: FetchableRecord, PersistableRecord { }
