//
//  Persistence.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

struct Persistence {
    
    init(){
        
        do {
            
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            

            let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")

            // 2. Define the database schema
            try dbQueue.write { db in
                try db.create(table: "tarjeta") { t in
                    t.primaryKey("id", .text).notNull()
                }
            }
            
            try dbQueue.write { db in
                try db.create(table: "alumno") { t in
                    t.primaryKey("id", .text).notNull()
                    t.column("name", .text).notNull()
                    t.column("lastname1", .text).notNull()
                    t.column("lastname2", .text).notNull()
                    t.column("academicId", .text).notNull()
                    t.column("idTarjeta", .text).notNull()
                    
                    t.foreignKey(["idTarjeta"], references: "tarjeta", onDelete: .cascade)
                }
            }
            
            
            try dbQueue.write { db in
                try db.create(table: "grupo") { t in
                    t.primaryKey("id", .text).notNull()
                    t.column("materia", .text).notNull()
                    t.column("carrera", .text).notNull()
                }
            }
            
            try dbQueue.write { db in
                try db.create(table: "alumnoGrupo") { t in
                    t.column("id", .integer).primaryKey(autoincrement: true)
                    t.column("idAlumno", .text).notNull()
                    t.column("idGrupo", .text).notNull()
                    
                    t.foreignKey(["idAlumno"], references: "alumno", onDelete: .cascade)
                    t.foreignKey(["idGrupo"], references: "grupo", onDelete: .cascade)
                }
            }
            
            try dbQueue.write { db in
                try Tarjeta(id: "12345-A").insert(db)
                try Tarjeta(id: "12345-B").insert(db)
                try Tarjeta(id: "12345-C").insert(db)
                try Tarjeta(id: "12345-D").insert(db)
            }
            
            // 4. Write and read in the database
            try dbQueue.write { db in
                try Alumno(id: "23456-A", name: "Arthur", lastname1: "Blade", lastname2: "Smith", academicId: "3162", idTarjeta: "12345-A").insert(db)
                try Alumno(id: "23456-B", name: "Barbara", lastname1: "Lopez", lastname2: "Velazquez", academicId: "3160", idTarjeta: "12345-B").insert(db)
                try Alumno(id: "23456-C", name: "Ivan", lastname1: "Perez", lastname2: "Gutierrez", academicId: "3164", idTarjeta: "12345-C").insert(db)
                try Alumno(id: "23456-D", name: "Ximena", lastname1: "Martinez", lastname2: "Salinas", academicId: "3165", idTarjeta: "12345-D").insert(db)
            }
            
            
            try dbQueue.write { db in
                try Grupo(id: "34567-A", materia: "Programacion", carrera: "Informatica").insert(db)
                try Grupo(id: "34567-B", materia: "Contaduria", carrera: "Contaduria").insert(db)
                try Grupo(id: "34567-C", materia: "Recursos Humanos", carrera: "Administracion").insert(db)
                try Grupo(id: "34567-D", materia: "Sistemas operativos", carrera: "Informatica").insert(db)
            }
            
            try dbQueue.write { db in
                
                try AlumnoGrupo(idAlumno: "23456-A", idGrupo: "34567-A").insert(db)
                try AlumnoGrupo(idAlumno: "23456-A", idGrupo: "34567-C").insert(db)
                try AlumnoGrupo(idAlumno: "23456-B", idGrupo: "34567-B").insert(db)
                try AlumnoGrupo(idAlumno: "23456-B", idGrupo: "34567-C").insert(db)
                try AlumnoGrupo(idAlumno: "23456-C", idGrupo: "34567-A").insert(db)
                try AlumnoGrupo(idAlumno: "23456-C", idGrupo: "34567-D").insert(db)
                try AlumnoGrupo(idAlumno: "23456-D", idGrupo: "34567-A").insert(db)
                try AlumnoGrupo(idAlumno: "23456-D", idGrupo: "34567-B").insert(db)
                
            }
            
            
            
            
        } catch {
            
        }
        
    }
    
    
    func grupos() -> [Grupo] {
        
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        

        let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")
        
        return try! dbQueue.read { db in
            try Grupo.fetchAll(db)
        }
    }
    
    func alumnos() -> [Alumno] {
        
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        

        let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")
        
        return try! dbQueue.read { db in
            try Alumno.fetchAll(db)
        }
    }
    
    func tarjetas() -> [Tarjeta] {
        
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        

        let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")
        
        return try! dbQueue.read { db in
            try Tarjeta.fetchAll(db)
        }
    }
    
    func alumnosGrupos() -> [AlumnoGrupo] {
        
        let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        

        let dbQueue = try! DatabaseQueue(path: path + "/db.sqlite")
        
        return try! dbQueue.read { db in
            try AlumnoGrupo.fetchAll(db)
        }
    }
    

    
    func updateAlumno(withId id: String, record: Alumno) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if var alumno = try Alumno.fetchOne(db, key: id) {
                    // Actualizar los campos necesarios
                    alumno.id = record.id
                    alumno.name = record.name
                    alumno.lastname1 = record.lastname1
                    alumno.lastname2 = record.lastname2
                    alumno.academicId = record.academicId
                    alumno.idTarjeta = record.idTarjeta
                    // Ejecutar la actualización en la base de datos
                    try alumno.update(db)
                } else {
                    // Manejar el caso en el que el alumno con el ID dado no fue encontrado
                    print("No se encontró un alumno con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al actualizar el alumno: \(error)")
        }
    }
    
    func updateGrupo(withId id: String, record: Grupo) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if var grupo = try Grupo.fetchOne(db, key: id) {
                    // Actualizar los campos necesarios
                    grupo.id = record.id
                    grupo.materia = record.materia
                    grupo.carrera = record.carrera
                    // Ejecutar la actualización en la base de datos
                    try grupo.update(db)
                } else {
                    // Manejar el caso en el que el grupo con el ID dado no fue encontrado
                    print("No se encontró una grupo con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al actualizar el grupo: \(error)")
        }
    }
    
    
    func deleteAlumno(withId id: String) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if let alumno = try Alumno.fetchOne(db, key: id) {
                    // Ejecutar la eliminación en la base de datos
                    try alumno.delete(db)
                } else {
                    // Manejar el caso en el que el alumno con el ID dado no fue encontrado
                    print("No se encontró un alumno con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al borrar el alumno: \(error)")
        }
    }
    
    func deleteTarjeta(withId id: String) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if let tarjeta = try Tarjeta.fetchOne(db, key: id) {
                    // Ejecutar la eliminación en la base de datos
                    try tarjeta.delete(db)
                } else {
                    // Manejar el caso en el que el alumno con el ID dado no fue encontrado
                    print("No se encontró una tarjeta con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al borrar el alumno: \(error)")
        }
    }
    
    func deleteGrupo(withId id: String) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                if let grupo = try Grupo.fetchOne(db, key: id) {
                    // Ejecutar la eliminación en la base de datos
                    try grupo.delete(db)
                } else {
                    // Manejar el caso en el que el grupo con el ID dado no fue encontrado
                    print("No se encontró un grupo con el ID \(id).")
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al borrar el grupo: \(error)")
        }
    }
    
    func deleteAlumnoGrupos(withIds ids: [Int64]) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                for id in ids {
                    if let alumnoGrupo = try AlumnoGrupo.fetchOne(db, key: id) {
                        // Ejecutar la eliminación en la base de datos
                        try alumnoGrupo.delete(db)
                    } else {
                        // Manejar el caso en el que el AlumnoGrupo con el ID dado no fue encontrado
                        print("No se encontró un AlumnoGrupo con el ID \(id).")
                    }
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al borrar los AlumnoGrupos: \(error)")
        }
    }
    
    func createAlumno(alumno: Alumno) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                // Crear un nuevo alumno en la base de datos
                try alumno.save(db)
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al crear el alumno: \(error)")
        }
    }
    
    func createAlumnoGrupos(alumnosGrupos: [AlumnoGrupo]) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                // Crear varios AlumnoGrupo en la base de datos
                for alumnoGrupo in alumnosGrupos {
                    try alumnoGrupo.save(db)
                }
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al crear los AlumnoGrupos: \(error)")
        }
    }

    
    func createTarjeta(tarjeta: Tarjeta) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                // Crear un nuevo alumno en la base de datos
                try tarjeta.save(db)
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al crear la tarjeta: \(error)")
        }
    }

    func createGrupo(grupo: Grupo) {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
            let dbQueue = try DatabaseQueue(path: path + "/db.sqlite")

            try dbQueue.write { db in
                // Crear un nuevo alumno en la base de datos
                try grupo.save(db)
            }
        } catch {
            // Manejar errores de la base de datos
            print("Error al crear el grupo: \(error)")
        }
    }

    
}
