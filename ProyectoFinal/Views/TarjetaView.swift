//
//  TarjetaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/12/23.
//

import SwiftUI

struct TarjetaView: View {
    
    let idRecord: String
    let record: Tarjeta?
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var tarjetaId: String = ""
    
    private func updateProperties() {
        if let record = record {
            tarjetaId = record.id
        }
    }
    
    func handleDelete() {
        
        viewModel.deleteTarjeta(withId: idRecord)
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleCreate() {
        let tarjeta = Tarjeta(id: tarjetaId)
        viewModel.createTarjeta(tarjeta: tarjeta)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        Form {
            if idRecord.isEmpty{
                HStack{
                    Text("Id:")
                    TextField("Ingrese tarjeta", text: $tarjetaId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        tarjetaId = viewModel.handleScan()
                    }) {
                        Text("Scanear")
                    }
                }
            } else {
                HStack{
                    Text("Id:")
                    Text(idRecord)
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
                    if idRecord.isEmpty {
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
