//
//  CoreDataManager.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 22/03/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductsModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("❌ Failed to load Core Data stack: \(error)")
            } else {
                print("✅ Successfully loaded: \(description)")
            }

            // Log loaded entities to confirm model is loaded
            print("Entities: \(container.managedObjectModel.entities.map { $0.name ?? "Unknown" })")
        }
        return container
    }()

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveProducts(_ products: [Products]) {
        
        if hasExistingProducts() {
            clearProducts()
        }

        for product in products {
            let entity = ProductEntity(context: context)
            entity.id = Int64(product.id)
            entity.title = product.title
            entity.bodyHTML = product.bodyHTML
            entity.imageSrc = product.image.src
            entity.imageWidth = Int64(product.image.width)
            entity.imageHeight = Int64(product.image.height)
            entity.summaryHTML = product.summaryHTML

            // Save image in the cache
            ImageCacheService().loadImage(for: product.id, from: product.image.src) { _,_  in }
        }

        do {
            try context.save()
            print("✅ Products saved to Core Data")
        } catch {
            print("❌ Failed to save products: \(error)")
        }
    }

    func fetchProducts() -> [Products] {
        let request: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            print("✅ Fetched \(entities.count) products from Core Data")
            return entities.map {
                Products(id: Int($0.id),
                         title: $0.title ?? "",
                         bodyHTML: $0.bodyHTML ?? "",
                         image: Image(width: Int($0.imageWidth),
                                      height: Int($0.imageHeight),
                                      src: $0.imageSrc ?? ""),
                         summaryHTML: $0.summaryHTML ?? "")
            }
        } catch {
            print("❌ Failed to fetch products: \(error)")
            return []
        }
    }

    private func clearProducts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ProductEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("✅ Cleared all products from Core Data")
        } catch {
            print("❌ Failed to clear products: \(error)")
        }
    }
    
    private func hasExistingProducts() -> Bool {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("❌ Error checking existing products: \(error)")
            return false
        }
    }

}
