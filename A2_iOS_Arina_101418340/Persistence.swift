import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_Arina_101418340")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        seedProductsIfNeeded()
    }

    private func seedProductsIfNeeded() {
        let context = container.viewContext
        let request: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            let count = try context.count(for: request)
            if count == 0 {
                let sampleProducts = [
                    (1, "iPhone 15", "Apple smartphone with advanced camera", 1299.99, "Apple"),
                    (2, "MacBook Air", "Lightweight laptop for students and work", 1499.99, "Apple"),
                    (3, "iPad Air", "Tablet for study and entertainment", 899.99, "Apple"),
                    (4, "AirPods Pro", "Wireless earbuds with noise cancellation", 329.99, "Apple"),
                    (5, "Apple Watch", "Smart watch for health tracking", 549.99, "Apple"),
                    (6, "Samsung Galaxy S24", "Android smartphone with powerful features", 1199.99, "Samsung"),
                    (7, "Dell XPS 13", "Compact laptop with premium build quality", 1599.99, "Dell"),
                    (8, "Sony WH-1000XM5", "Noise cancelling over-ear headphones", 499.99, "Sony"),
                    (9, "Canon EOS R50", "Mirrorless camera for creators", 999.99, "Canon"),
                    (10, "Nintendo Switch", "Hybrid gaming console for home and travel", 399.99, "Nintendo")
                ]

                for item in sampleProducts {
                    let product = Product(context: context)
                    product.id = UUID()
                    product.productID = Int64(item.0)
                    product.name = item.1
                    product.productDescription = item.2
                    product.price = item.3
                    product.provider = item.4
                }

                try context.save()
            }
        } catch {
            print("Failed to seed products: \(error.localizedDescription)")
        }
    }
}
