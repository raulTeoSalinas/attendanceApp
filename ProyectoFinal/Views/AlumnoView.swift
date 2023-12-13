//
//  PersonView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import SwiftUI

struct AlumnoView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var name: String = ""
    @State private var lastname1: String = ""
    @State private var lastname2: String = ""
    @State private var academicId: String = ""
    @State private var selectedIdTarjeta: Int = 0
    @State private var idsFromAlumnoGrupo: [Int64] = []
    @State private var indexSelectedGrupos: [Int] = []
    
    let alumno: Alumno?
    
    private func updateProperties() {
        guard let record = alumno else {
            // Si record no existe, no actualizar nada
            return
        }
        
        name = record.name
        lastname1 = record.lastname1
        lastname2 = record.lastname2
        academicId = record.academicId
        
        if let index = viewModel.tarjetas.firstIndex(where: { $0.id == record.idTarjeta }) {
            selectedIdTarjeta = index
        } else {
            selectedIdTarjeta = 0
        }
    }
    func handleUpdate() {
        
        let alumno = Alumno(
            name: name,
            lastname1: lastname1,
            lastname2: lastname2,
            academicId: academicId,
            idTarjeta: viewModel.tarjetas[selectedIdTarjeta].id
        )
        
        viewModel.updateAlumno(record: alumno)
        
        // Después de la actualización, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleDelete() {
        guard let alumno = alumno else { return }
        viewModel.deleteAlumno(alumno: alumno)
        // Después de la eliminación, navegar hacia atrás
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleCreate() {
        
        let alumno = Alumno(
            name: name,
            lastname1: lastname1,
            lastname2: lastname2,
            academicId: academicId,
            idTarjeta: viewModel.tarjetas[selectedIdTarjeta].id
        )
        
        viewModel.createAlumno(alumno: alumno)
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func handleAddGrupo(){
        
        if let firstUnselectedIndex = viewModel.grupos.indices.first(where: { !indexSelectedGrupos.contains($0) }) {
            indexSelectedGrupos.append(firstUnselectedIndex)
        }
    }
    
    func handleDeleteGrupo(id: Int){
        indexSelectedGrupos.removeAll { $0 == id }
        
    }
    
    var body: some View {
        
        List{
            Section(header: Text("Información Personal")) {
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
                
                if alumno == nil {
                    Button(action: {
                        handleDelete()
                    }) {
                        Text("Borrar")
                    }
                }
                
            }
            Text("Grupo")
            if let grupo = viewModel.getGrupoFromAlumno(idGrupo: alumno?.idGrupo) {
                Text("Materia \(grupo.materia))")
                Text("Grupo \(grupo.carrera))")
            }
        }
        
        
        .onAppear {
            updateProperties()
        }
        .navigationBarItems(
            trailing: {
                if alumno == nil {
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
