//
//  TarjetaView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/12/23.
//

import SwiftUI

struct TarjetaView: View {
    

    let tarjeta: Tarjeta?
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var tarjetaId: String = ""
    
    private func updateProperties() {
        if let tarjeta = tarjeta {
            tarjetaId = tarjeta.id
        }
    }
    

    func handleDelete() {
        guard let tarjeta = tarjeta else { return }
        viewModel.deleteTarjeta(tarjeta: tarjeta)
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
            if tarjeta == nil{
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
