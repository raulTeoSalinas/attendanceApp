//
//  Persistence.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

/// El protocolo `Persistence` define los requisitos básicos para una capa de persistencia.
///
/// Los tipos que lo implementen deben proporcionar una cola de base de datos (`dbQueue`) para realizar operaciones en la base de datos
/// y la ruta al archivo de la base de datos (`dbPath`).
protocol Persistence {
    /// Una cola para realizar operaciones en la base de datos.
    var dbQueue: DatabaseQueue { get }
    /// La ruta al archivo de la base de datos.
    var dbPath: String { get }
}

/// `PersistenceImpl` es una implementación de la interfaz ``Persistence`` que proporciona funcionalidad para la capa de persistencia.
///
/// Esta estructura gestiona la cola de la base de datos (`dbQueue`) y la ruta al archivo de la base de datos (`dbPath`).
/// Además, realiza algunas operaciones de inicialización, como la configuración de migraciones y la población inicial de datos.
struct PersistenceImpl: Persistence {
    /// La cola para realizar operaciones en la base de datos.
    var dbQueue: DatabaseQueue
    /// La ruta al archivo de la base de datos.
    var dbPath: String
    /// Inicializa una nueva instancia de `PersistenceImpl`.
        /// - Important: Esta inicialización asume que la base de datos ya existe y está configurada.
    init() {
        /// Configuración de la ruta y la cola de la base de datos.
        dbPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/db.sqlite"
        dbQueue = try! DatabaseQueue(path: dbPath)
        /// Configuración de migraciones y población de prueba de la base de datos.
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
    
    
    /// Realiza una población ficticia de datos en la base de datos.
        ///
        /// Esta función inserta datos de prueba, como tarjetas, grupos y alumnos, en la base de datos
        /// para propósitos de desarrollo y pruebas. Ten en cuenta que esta población ficticia asume que
        /// no hay restricciones únicas en las entidades, ya que se insertan datos que podrían violar
        /// estas restricciones en un entorno de producción.
        ///
        /// - Throws: Se lanza un error si ocurre algún problema durante la inserción de datos.
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
        
        let alumnosId = try dbQueue.read { db in try Alumno.fetchAll(db) }.compactMap { $0.id}
        
        try dbQueue.write { db in
            try Asistencia(idGrupo: gruposId[0], idAlumno: alumnosId[0]).insert(db)
            try Asistencia(idGrupo: gruposId[0], idAlumno: alumnosId[1]).insert(db)
            try Asistencia(idGrupo: gruposId[0], idAlumno: alumnosId[1]).insert(db)
            try Asistencia(idGrupo: gruposId[0], idAlumno: alumnosId[1]).insert(db)
            
            try Asistencia(idGrupo: gruposId[1], idAlumno: alumnosId[2]).insert(db)
            try Asistencia(idGrupo: gruposId[1], idAlumno: alumnosId[2]).insert(db)
            try Asistencia(idGrupo: gruposId[1], idAlumno: alumnosId[2]).insert(db)
            try Asistencia(idGrupo: gruposId[1], idAlumno: alumnosId[0]).insert(db)
            try Asistencia(idGrupo: gruposId[1], idAlumno: alumnosId[0]).insert(db)
            try Asistencia(idGrupo: gruposId[1], idAlumno: alumnosId[0]).insert(db)
            
            try Asistencia(idGrupo: gruposId[2], idAlumno: alumnosId[0]).insert(db)
            try Asistencia(idGrupo: gruposId[2], idAlumno: alumnosId[0]).insert(db)
            try Asistencia(idGrupo: gruposId[2], idAlumno: alumnosId[1]).insert(db)
            try Asistencia(idGrupo: gruposId[2], idAlumno: alumnosId[1]).insert(db)
            try Asistencia(idGrupo: gruposId[2], idAlumno: alumnosId[2]).insert(db)
            try Asistencia(idGrupo: gruposId[2], idAlumno: alumnosId[2]).insert(db)

        }
    }
    
}
