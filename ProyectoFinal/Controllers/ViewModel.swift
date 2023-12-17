//
//  ViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

class ViewModel: ObservableObject {
    
    @Published var alumnos = [Alumno]()
    @Published var grupos = [Grupo]()
    @Published var tarjetas = [Tarjeta]()
    @Published var asistencias = [Asistencia]()
    
    private let alumnosDAO: AlumnoDAO
    private let grupoDAO: GrupoDAO
    private let tarjetaDAO: TarjetaDAO
    private let asistenciaDAO: AsistenciaDAO
    private let serviceNFC: ServiceNFC
    
    init(
        alumnosDAO: AlumnoDAO,
        grupoDAO: GrupoDAO,
        tarjetaDAO: TarjetaDAO,
        asistenciaDAO: AsistenciaDAO
    ) {
        self.alumnosDAO = alumnosDAO
        self.grupoDAO = grupoDAO
        self.tarjetaDAO = tarjetaDAO
        self.asistenciaDAO = asistenciaDAO
        
        
        alumnos = try! alumnosDAO.getAlumnos()
        grupos = try! grupoDAO.getGrupos()
        tarjetas = try! tarjetaDAO.getTarjetas()
        asistencias = try! asistenciaDAO.getAsistencias()
        serviceNFC = ServiceNFC()
    }
    
    func updateAlumno(record: Alumno) {
        do {
            try alumnosDAO.updateAlumno(record: record)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    func updateGrupo(record: Grupo) {
        do {
            try grupoDAO.updateGrupo(record: record)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    func deleteAlumno(alumno: Alumno){
        do {
            try alumnosDAO.deleteAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    func deleteTarjeta(tarjeta: Tarjeta){
        do {
            try tarjetaDAO.deleteTarjeta(tarjeta: tarjeta)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    func deleteGrupo(grupo: Grupo){
        do {
            try grupoDAO.deleteGrupo(record: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    func createAlumno(alumno: Alumno){
        do {
            try alumnosDAO.createAlumno(alumno: alumno)
            alumnos = try alumnosDAO.getAlumnos()
        } catch { }
    }
    
    func createGrupo(grupo: Grupo){
        do {
            try grupoDAO.createGrupo(grupo: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }

    func createTarjeta(tarjeta: Tarjeta){
        do {
            try tarjetaDAO.createTarjeta(tarjeta: tarjeta)
            tarjetas = try tarjetaDAO.getTarjetas()
        } catch { }
    }
    
    func getGrupoFromAlumno(idGrupo: Int64?) -> Grupo? {
        guard idGrupo != nil else { return nil }
        return grupos.filter { $0.id == idGrupo }.first
    }
    
    func handleScan(completion: @escaping (String) -> Void) {
        
        serviceNFC.read(completion: completion)
    }
    
    func searchAlumnoByIdCard(idTarjeta: String) -> Int64? {
        if let alumno = alumnos.first(where: { $0.idTarjeta == idTarjeta }) {
            return alumno.id
        } else {
            return nil
        }
    }
    
    func createAsistencia(idGrupo: Int64, idTarjeta: String){
        if let idAlumno = searchAlumnoByIdCard(idTarjeta: idTarjeta) {
            
            let asistencia = Asistencia(idGrupo: idGrupo, idAlumno: idAlumno)

            do {
                try asistenciaDAO.createAsistencia(asistencia: asistencia)
                asistencias = try asistenciaDAO.getAsistencias()
            } catch { }
            
        } else {
            
            print("No se encontró ningún alumno con la tarjeta \(idTarjeta)")
        }
    }
    
    func getAlumnoAsistenciaCount(grupo: Grupo) -> [String: Int] {
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
