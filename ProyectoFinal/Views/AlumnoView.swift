//
//  PersonView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import SwiftUI

struct AlumnoView: View {
    
    let idRecord: String

    let record: Alumno?
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var id: String = ""
    @State private var name: String = ""
    @State private var lastname1: String = ""
    @State private var lastname2: String = ""
    @State private var academicId: String = ""
    
    @State private var selectedIdTarjeta: Int = 0
    
    @State private var numberOfGrupos: Int = 0
    @State private var indexSelectedGrupos: [Int] = []

    
    private func updateProperties() {
        guard let record = record else {
            // Si record no existe, no actualizar nada
            return
        }
        
        id = record.id
        name = record.name
        lastname1 = record.lastname1
        lastname2 = record.lastname2
        academicId = record.academicId
        
        if let index = viewModel.tarjetas.firstIndex(where: { $0.id == record.idTarjeta }) {
            selectedIdTarjeta = index
        } else {
            selectedIdTarjeta = 0
        }
        
        for i in 0..<viewModel.alumnosGrupos.count {
            if viewModel.alumnosGrupos[i].idAlumno == record.id {
                numberOfGrupos += 1
                
                // Bucle anidado para buscar coincidencias con grupos
                for j in 0..<viewModel.grupos.count {
                    if viewModel.alumnosGrupos[i].idGrupo == viewModel.grupos[j].id {
                        // Almacena la posición del grupo en indexSelectedGrupos
                        indexSelectedGrupos.append(j)

                    }
                }
            }
            print(indexSelectedGrupos)
            
        }
        
    }
    func handleUpdate() {

        let alumno = Alumno(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId, idTarjeta: viewModel.tarjetas[selectedIdTarjeta].id)

        viewModel.updateAlumno(withId: idRecord, record: alumno)

        // Después de la actualización, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDelete() {
        viewModel.deleteAlumno(withId: idRecord)
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleCreate() {
        
        let alumno = Alumno(id: id, name: name, lastname1: lastname1, lastname2: lastname2, academicId: academicId, idTarjeta: "hola")
            viewModel.createAlumno(alumno: alumno)
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleScan() {
        let randomString = String((0..<10).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".randomElement()! })
        id = randomString
    }
    
    var body: some View {
      
        List{
            Section(header: Text("Información Personal")) {
                if idRecord.isEmpty {
                    HStack{
                        Text("ID:")
                        
                        TextField("Ingrese id", text: $id)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            handleScan()
                        }) {
                            Text("Autogenerar")
                        }
                    }
                }
                
                HStack{
                    Text("Nombre:")
                    
                    TextField("Ingrese nombre", text: $name)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Apellido 1:")
                    
                    TextField("Ingrese apellido 1", text: $lastname1)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Apellido 2:")
                    
                    TextField("Ingrese apellido 2", text: $lastname2)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("Número de Cuenta:")
                    
                    TextField("Ingrese número de cuenta", text: $academicId)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                
                Picker("Tarjeta", selection: $selectedIdTarjeta) {
                    ForEach(Array(viewModel.tarjetas.enumerated()), id: \.1.id) { index, tarjeta in
                        Text(tarjeta.id)
                            .tag(index) // Asigna un valor único (índice) como tag
                    }
                }
                
                
                if !idRecord.isEmpty {
                    Button(action: {
                        handleDelete()
                    }) {
                        Text("Borrar")
                    }
                }
                
            }
            
            Section(header: Text("Grupos")) {
                
                
                ForEach(indexSelectedGrupos.indices, id: \.self) { i in
                    Picker("", selection: $indexSelectedGrupos[i]) {
                        ForEach(viewModel.grupos.indices, id: \.self) { sGIndex in
                            Text(viewModel.grupos[sGIndex].materia).tag(sGIndex)
                        }
                    }
                }

                
            }
        
            
        }
            
        
            .onAppear {
                updateProperties()
            }
            .navigationBarItems(
                trailing: {
                    if idRecord.isEmpty {
                        Button(action: {
                            handleCreate()
                        }) {
                            Text("Crear")
                        }
                    } else {
                        Button(action: {
                            handleUpdate()
                        }) {
                            Text("Actualizar")
                        }
                    }
                }()
            )


    }
}

//#Preview {
//    RecordView(typeEntity: "Alumno", idRecord: "4120")
//}
