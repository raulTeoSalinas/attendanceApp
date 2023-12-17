//
//  GrupoViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/17/23.
//

import Foundation

class GrupoViewModel: ObservableObject {
    
    @Published var grupos = [Grupo]()
    private let grupoDAO: GrupoDAO

    init(grupoDAO: GrupoDAO) {

        self.grupoDAO = grupoDAO
        grupos = try! grupoDAO.getGrupos()
    }
    
    func createGrupo(grupo: Grupo){
        do {
            try grupoDAO.createGrupo(grupo: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    func updateGrupo(record: Grupo) {
        do {
            try grupoDAO.updateGrupo(record: record)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    func deleteGrupo(grupo: Grupo){
        do {
            try grupoDAO.deleteGrupo(record: grupo)
            grupos = try grupoDAO.getGrupos()
        } catch { }
    }
    
    
    
    
}
