//
//  MenuAsistenciaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/16/23.
//

import SwiftUI

/// `MenuAsistenciaView` es una vista que presenta opciones de navegación relacionadas con la asistencia para un grupo específico.
struct MenuAsistenciaView: View {
    
    /// Grupo seleccionado para el cual se gestionará la asistencia.
    let grupoSelected: Grupo
    
    var body: some View {
        List{
            NavigationLink(destination: AsistenciaView(grupoSelected: grupoSelected)) {
                Text("Tomar asistencia")
            }
            NavigationLink(destination: ReportAsistenciaView(grupoSelected: grupoSelected)) {
                Text("Ver informe (contador)")
            }
        }.navigationTitle(grupoSelected.materia)
    }
}


