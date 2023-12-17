//
//  Asistencia.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/16/23.
//

import Foundation
import GRDB

struct Asistencia: Codable, Identifiable {
    var id: Int64?
    var time: Date
    var idGrupo: Int64
    var idAlumno: Int64
    
    init(id: Int64? = nil, time: Date = Date(), idGrupo: Int64, idAlumno: Int64) {
        self.id = id
        self.time = time
        self.idGrupo = idGrupo
        self.idAlumno = idAlumno
    }
    
}

extension Asistencia: FetchableRecord, PersistableRecord { }
