//
//  Persistence.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

protocol Persistence {
    
    var dbQueue: DatabaseQueue { get }
    var dbPath: String { get }
}

struct PersistenceImpl: Persistence {
    
    var dbQueue: DatabaseQueue
    var dbPath: String
    
    init() {
        dbPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/db.sqlite"
        dbQueue = try! DatabaseQueue(path: dbPath)
        
        let migrations = Migrations()
        try! migrations.v1(dbQueue: dbQueue)
        do {
            try fakePopulate()
        } catch {
            print(error)
        }
    }
}


extension PersistenceImpl {
    
    func fakePopulate() throws {
        
        try dbQueue.write { db in
            try Tarjeta(id: "12345-A").insert(db)
            try Tarjeta(id: "12345-B").insert(db)
            try Tarjeta(id: "12345-C").insert(db)
            try Tarjeta(id: "12345-D").insert(db)
        }
        
        
        try dbQueue.write { db in
            try Grupo(materia: "Programacion", carrera: "Informatica").insert(db)
            try Grupo(materia: "Contaduria", carrera: "Contaduria").insert(db)
            try Grupo(materia: "Recursos Humanos", carrera: "Administracion").insert(db)
            try Grupo(materia: "Sistemas operativos", carrera: "Informatica").insert(db)
        }
        
        let gruposId = try dbQueue.read { db in try Grupo.fetchAll(db) }.compactMap { $0.id}
        let tarjetasId = try dbQueue.read { db in try Tarjeta.fetchAll(db) }.compactMap { $0.id}
        
        try dbQueue.write { db in
            try Alumno(name: "Arthur", lastname1: "Blade", lastname2: "Smith", academicId: "3162", idTarjeta: tarjetasId[0], idGrupo: gruposId[0]).insert(db)
            try Alumno(name: "Barbara", lastname1: "Lopez", lastname2: "Velazquez", academicId: "3160", idTarjeta: tarjetasId[1], idGrupo: gruposId[1] ).insert(db)
            try Alumno(name: "Ivan", lastname1: "Perez", lastname2: "Gutierrez", academicId: "3164", idTarjeta: tarjetasId[2], idGrupo: gruposId[2]).insert(db)
        }
    }
    
}
