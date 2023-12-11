//
//  ProyectoFinalApp.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

@main
struct ProyectoFinalApp: App {
    let viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            let _ = Persistence()
            HomeView().environmentObject(viewModel)
        }
    }
}
