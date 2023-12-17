//
//  AsistenciaViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

class AsistenciaViewModel: ObservableObject {
    
    @Published var asistencias = [Asistencia]()
    
    private let asistenciaDAO: AsistenciaDAO

    init(asistenciaDAO: AsistenciaDAO) {

        self.asistenciaDAO = asistenciaDAO
        asistencias = try! asistenciaDAO.getAsistencias()
    }
    
    func searchAlumnoByIdCard(idTarjeta: String, alumnos: [Alumno]) -> Int64? {
        if let alumno = alumnos.first(where: { $0.idTarjeta == idTarjeta }) {
            return alumno.id
        } else {
            return nil
        }
    }
    
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
