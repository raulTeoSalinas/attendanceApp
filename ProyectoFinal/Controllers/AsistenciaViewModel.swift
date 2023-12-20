//
//  AsistenciaViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

/// `AsistenciaViewModel` es una clase observable que gestiona la lógica relacionada con la entidad ``Asistencia``.
class AsistenciaViewModel: ObservableObject {
    
    /// Una lista de objetos ``Asistencia``.
    @Published var asistencias = [Asistencia]()
    
    /// El objeto ``AsistenciaDAO`` utilizado para realizar operaciones de acceso a datos relacionadas con Asistencias.
    private let asistenciaDAO: AsistenciaDAO
    
    /// Inicializa una nueva instancia de `AsistenciaViewModel`.
    ///
    /// - Parameter asistenciaDAO: El objeto ``AsistenciaDAO`` que proporciona operaciones de acceso a datos.
    init(asistenciaDAO: AsistenciaDAO) {

        self.asistenciaDAO = asistenciaDAO
        asistencias = try! asistenciaDAO.getAsistencias()
    }
    
    /// Busca el ID de un alumno basado en el número de tarjeta NFC y la lista de alumnos.
        ///
        /// - Parameters:
        ///   - idTarjeta: El número de tarjeta NFC.
        ///   - alumnos: La lista de objetos `Alumno`.
        /// - Returns: El ID del alumno si se encuentra, o `nil` si no se encuentra.
    func searchAlumnoByIdCard(idTarjeta: String, alumnos: [Alumno]) -> Int64? {
        if let alumno = alumnos.first(where: { $0.idTarjeta == idTarjeta }) {
            return alumno.id
        } else {
            return nil
        }
    }
    
    /// Crea una nueva asistencia y actualiza la lista de asistencias.
        ///
        /// - Parameters:
        ///   - idGrupo: El ID del grupo asociado a la asistencia.
        ///   - idTarjeta: El número de tarjeta NFC del alumno.
        ///   - alumnos: La lista de objetos ``Alumno``.
    func createAsistencia(idGrupo: Int64, idTarjeta: String, alumnos: [Alumno]){
        if let idAlumno = searchAlumnoByIdCard(idTarjeta: idTarjeta, alumnos: alumnos) {
            
            let asistencia = Asistencia(idGrupo: idGrupo, idAlumno: idAlumno)

            do {
                try asistenciaDAO.createAsistencia(asistencia: asistencia)
                asistencias = try asistenciaDAO.getAsistencias()
            } catch { }
            
        } else {
            
            print("No se encontró ningún alumno con la tarjeta \(idTarjeta)")
        }
    }
    
    /// Obtiene el conteo de asistencias por alumno para un grupo específico.
        ///
        /// - Parameters:
        ///   - grupo: El objeto ``Grupo`` para el cual se desea obtener el conteo de asistencias.
        ///   - alumnos: La lista de objetos ``Alumno``.
        /// - Returns: Un diccionario que mapea el nombre completo del alumno al número de asistencias.
    func getAlumnoAsistenciaCount(grupo: Grupo, alumnos: [Alumno]) -> [String: Int] {
        // Filtrar las asistencias para obtener solo las del grupo especificado
        let asistenciasGrupo = asistencias.filter { $0.idGrupo == grupo.id }

        // Utilizar la función reduce para construir el diccionario de conteo de asistencias
        let asistenciasCount = asistenciasGrupo.reduce(into: [String: Int]()) { counts, asistencia in
            // Buscar el alumno correspondiente a la asistencia
            if let alumno = alumnos.first(where: { $0.id == asistencia.idAlumno }) {
                // Incrementar el conteo de asistencias para el alumno
                counts["\(alumno.lastname1) \(alumno.lastname2) \(alumno.name)"] = (counts["\(alumno.lastname1) \(alumno.lastname2) \(alumno.name)"] ?? 0) + 1
            }
        }

        return asistenciasCount
    }
    
    
}
