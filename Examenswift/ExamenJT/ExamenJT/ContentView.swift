//
//  ContentView.swift
//  ExamenJT
//
//  Created by CCDM18 on 17/11/22.
//

import SwiftUI
import CoreData
struct ContentView: View {
    let coreDM: CoreDataManager
    @State var idProducto = ""
    @State var nombre = ""
    @State var marca = ""
    @State var precio = ""
    @State var existencia = ""
    
    @State var newidProducto = ""
    @State var newnombre = ""
    @State var newmarca = ""
    @State var newprecio = ""
    @State var newexistencia = ""
    
    @State var seleccionado:Producto?
    @State var prodArray = [Producto]()
    @State var isTapped = false
    var body: some View {
        NavigationView{
        VStack {
            Text("PRODUCTOS")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
                NavigationLink(destination: VStack{
                    TextField("ID Producto",text:self.$newidProducto)
                .textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                    TextField("Nombre",text:self.$newnombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Marca",text:self.$newmarca)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Precio",text:self.$newprecio)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Existencia",text:self.$newexistencia)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        Button("Guardar"){
                coreDM.guardarProducto(idProducto: newidProducto, nombre: newnombre, marca: newmarca, precio: newprecio, existencia: newexistencia)
                
                newidProducto=""
                newnombre=""
                newmarca=""
                newprecio=""
                newexistencia=""
                mostrarProductos()
            }
            }){
                Text("Agregar")
                    .underline()
                    .foregroundColor(.black)
                
            }
            List{
                ForEach(prodArray, id: \.self){
                    prod in
                    VStack{
                        Text(prod.idProducto ?? "")
                        Text(prod.nombre ?? "")
                        Text(prod.marca ?? "")
                        Text(prod.precio ?? "")
                        Text(prod.existencia ?? "")
                        
                    }
                    .onTapGesture {
                        seleccionado=prod
                        idProducto=prod.idProducto ?? ""
                        nombre=prod.nombre ?? ""
                        marca=prod.marca ?? ""
                        precio=prod.precio ?? ""
                        existencia=prod.existencia ?? ""
                        isTapped.toggle()
                    }
                }
                .onDelete(perform: {
                    indexSet in
                    indexSet.forEach({index in
                        let producto=prodArray[index]
                        coreDM.borrarProducto(producto: producto)
                        mostrarProductos()
                    })
                })
            }.padding()
                .onAppear(perform: {mostrarProductos()})
                    
                NavigationLink("Actualizar",destination:
                                VStack{
                    TextField("Producto:",text:self.$idProducto).textFieldStyle(RoundedBorderTextFieldStyle()).keyboardType(.numberPad)
                    
                  
                    TextField("nombre:",text:self.$nombre).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                    TextField("marca:",text:self.$marca).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                  
                    TextField("precio:",text:self.$precio).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                
                    TextField("existencia:",text:self.$existencia).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Update"){
                        seleccionado?.idProducto=idProducto
                        seleccionado?.nombre=nombre
                        seleccionado?.marca=marca
                        seleccionado?.precio=precio
                        seleccionado?.existencia=existencia
                        
                        coreDM.actualizarProducto(producto: seleccionado!)
                        idProducto=""
                        nombre=""
                        marca=""
                        precio=""
                        existencia=""
                        mostrarProductos()
                    }
                },isActive: $isTapped)
            }
        }
    }
    func mostrarProductos(){
        prodArray=coreDM.leerProductos()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
