//
//  CoreDataManager.swift
//  ExamenJT
//
//  Created by CCDM18 on 17/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer:NSPersistentContainer
    init(){
        persistentContainer=NSPersistentContainer(name:"Producto")
        persistentContainer.loadPersistentStores(completionHandler: {
            (description,error)in
            if let error=error{
                fatalError("Core data failed to initialize\(error.localizedDescription)")
            }
        })
    }
    func guardarProducto(idProducto:String,nombre:String,marca:String,precio:String,existencia:String){
        let producto=Producto(context: persistentContainer.viewContext)
        producto.idProducto = idProducto
        producto.nombre=nombre
        producto.marca=marca
        producto.precio=precio
        producto.existencia=existencia
        do{
            try persistentContainer.viewContext.save()
            print("Producto guardado")
        }
        catch{
            print("Failed to save error en\(error)")
        }
    }
    func leerProductos() -> [Producto]{
        let fetchRequest : NSFetchRequest<Producto> = Producto.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return []
        }
    }
    func leerProducto(idProducto:String) -> Producto?{
        let fetchRequest : NSFetchRequest<Producto> = Producto.fetchRequest()
        let predicate = NSPredicate(format: "idProducto = %@",idProducto)
        fetchRequest.predicate=predicate
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }catch{
            print("Failed to save error en\(error)")
        }
        return nil
    }
    func actualizarProducto(producto: Producto){
        let fetchRequest : NSFetchRequest<Producto> = Producto.fetchRequest()
        let predicate = NSPredicate(format: "idProducto = %@",producto.idProducto ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let p = datos.first
            p?.idProducto = producto.idProducto
            p?.nombre = producto.nombre
            p?.marca = producto.marca
            p?.precio = producto.precio
            p?.existencia = producto.existencia
            try persistentContainer.viewContext.save()
            print("Producto guardado")
        }
        catch{
            print("Failed to save error en\(error)")
        }
    }
    
    func borrarProducto(producto:Producto){
        persistentContainer.viewContext.delete(producto)
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
}
