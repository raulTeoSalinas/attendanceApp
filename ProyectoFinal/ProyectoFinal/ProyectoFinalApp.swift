//
//  ProyectoFinalApp.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

@main
struct ProyectoFinalApp: App {
    
    let main = ServiceMain()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(main.serviceVm.alumnoViewModel).environmentObject(main.serviceVm.grupoViewModel).environmentObject(main.serviceVm.tarjetaViewModel).environmentObject(main.serviceVm.asistenciaViewModel)
        }
    }
}
