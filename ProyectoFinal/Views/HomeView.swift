//
//  ContentView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

struct HomeView: View {
    
    let menuItems: [MenuItem] = [
            MenuItem(name: "Alumnos"),
            MenuItem(name: "Profesores"),
            MenuItem(name: "Materias")
    ]
    
    let viewModel = ViewModel()
    
    
    var body: some View {
        NavigationStack {
            List(menuItems) { menuItem in
                NavigationLink(destination: EntityList(typeEntity: menuItem.name, viewModel: ViewModel())){
                    VStack{
                        Text(menuItem.name)
                            .padding()
                            .foregroundColor(.white)
                    }
                }
                .listRowBackground(Color(red: 0.44, green: 0.27, blue: 0.96))
                .listRowSeparatorTint(.white)

                
            }
            .navigationTitle("Sistema Escolar")
            
        }
    }
}

#Preview {
    HomeView()
}
