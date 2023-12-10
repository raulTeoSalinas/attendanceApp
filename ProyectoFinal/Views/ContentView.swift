//
//  ContentView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

struct ContentView: View {
    
    let menuItems: [MenuItem] = [
            MenuItem(name: "Alumnos"),
            MenuItem(name: "Profesores"),
            MenuItem(name: "Materias")
    ]
    
    
    
    var body: some View {
        NavigationStack {
            List(menuItems) { menuItem in
                NavigationLink(destination: Text(menuItem.name)){
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
    ContentView()
}
