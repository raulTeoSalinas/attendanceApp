//
//  TarjetaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/12/23.
//

import SwiftUI

/// `TarjetaView` es una vista que permite la gestión de tarjetas, incluyendo la creación y eliminación.
struct TarjetaView: View {
    
    /// El ViewModel principal de la aplicación.
    @EnvironmentObject var mainVM: MainViewModel
    
    /// Control de presentación para navegar hacia atrás.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var tarjetaId: String = ""
    
    /// Tarjeta existente para actualizar o eliminar.
    let tarjeta: Tarjeta?
    
    private func updateProperties() {
        if let tarjeta = tarjeta {
            tarjetaId = tarjeta.id
        }
    }
    

    func handleDelete() {
        guard let tarjeta = tarjeta else { return }
        mainVM.tarjetaViewModel.deleteTarjeta(tarjeta: tarjeta)
        mainVM.objectWillChange.send()
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    func handleCreate() {
        let tarjeta = Tarjeta(id: tarjetaId)
        mainVM.tarjetaViewModel.createTarjeta(tarjeta: tarjeta)
        mainVM.objectWillChange.send()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        Form {
            if tarjeta == nil{
                HStack{
                    Text("Id:")
                    TextField("Ingrese tarjeta", text: $tarjetaId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        
                        mainVM.tarjetaViewModel.handleScan(completion: { readId in
                            self.tarjetaId = readId
                            let tarjeta = Tarjeta(id: tarjetaId)
                            mainVM.tarjetaViewModel.createTarjeta(tarjeta: tarjeta)
                        })
                        
                        
                    }) {
                        Text("Scanear")
                    }
                }
            } else {
                HStack{
                    Text("Id:")
                    Text(tarjeta?.id ?? "")
                }
                Button(action: {
                    handleDelete()
                }) {
                    Text("Borrar")
                }
            }
        }
        .onAppear {
            updateProperties()
        }
        .navigationBarItems(
            trailing: {
                Group {
                    if tarjeta == nil {
                        Button(action: {
                            handleCreate()
                        }) {
                            Text("Crear")
                        }
                    } else {
                        EmptyView()
                    }
                }
            }()
        )
    }
}
