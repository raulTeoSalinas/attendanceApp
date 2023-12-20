//
//  GrupoViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

/// `GrupoViewModel` es una clase observable que gestiona la lógica relacionada con la entidad ``Grupo``.
class GrupoViewModel: ObservableObject {
    
    /// Una lista de objetos ``Grupo``.
    @Published var grupos = [Grupo]()
    
    /// El objeto ``GrupoDAO`` utilizado para realizar operaciones de acceso a datos relacionadas con Grupos.
    private let grupoDAO: GrupoDAO

    /// Inicializa una nueva instancia de `GrupoViewModel`.
        ///
        /// - Parameter grupoDAO: El objeto `GrupoDAO` que proporciona operaciones de acceso a datos.
    init(grupoDAO: GrupoDAO) {
        self.grupoDAO = grupoDAO
        grupos = try! grupoDAO.getGrupos()
    }
    
    /// Crea un nuevo grupo y actualiza la lista de grupos.
        ///
        /// - Parameter grupo: El objeto ``Grupo`` que se va a crear.
    func createGrupo(grupo: Grupo){
        do {
            try grupoDAO.createGrupo(grupo: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    /// Actualiza la información de un grupo existente y actualiza la lista de grupos.
        ///
        /// - Parameter record: El objeto ``Grupo`` con la información actualizada.
    func updateGrupo(record: Grupo) {
        do {
            try grupoDAO.updateGrupo(record: record)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    /// Elimina un grupo y actualiza la lista de grupos.
        ///
        /// - Parameter grupo: El objeto ``Grupo`` que se va a eliminar.
    func deleteGrupo(grupo: Grupo){
        do {
            try grupoDAO.deleteGrupo(record: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    
    
    
}
