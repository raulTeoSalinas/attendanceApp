//
//  ContentView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

struct HomeView: View {
    
    let menuItemsCrud: [MenuItem] = [
            MenuItem(name: "Alumnos"),
            MenuItem(name: "Profesores"),
            MenuItem(name: "Grupos")
    ]
    
    let menuItemsAsistencia: [MenuItem] = [
            MenuItem(name: "Alumnos"),
            MenuItem(name: "Profesores")
    ]
   
    var body: some View {
        NavigationStack {
            Section(header: Text("CRUD")) {
                List(menuItemsCrud) { menuItem in
                    NavigationLink(destination: EntityList(typeEntity: menuItem.name)){
                            Text(menuItem.name)
                                .padding()
                                .foregroundColor(.white)
                        
                    }
                    .listRowBackground(Color(red: 0.44, green: 0.27, blue: 0.96))
                    .listRowSeparatorTint(.white)
                    
                    
                }
            }
            Section(header: Text("Asistencia")) {
                List(menuItemsAsistencia) { menuItem in
                    NavigationLink(destination: EntityList(typeEntity: menuItem.name)){
 
                            Text(menuItem.name)
                                .padding()
                                .foregroundColor(.white)
                        
                    }
                    .listRowBackground(Color(red: 0.44, green: 0.27, blue: 0.96))
                    .listRowSeparatorTint(.white)
                    
                    
                }
            }
            .navigationTitle("Sistema Escolar")
            
        }
    }
}

#Preview {
    HomeView()
}
