import CoreData
import UIKit

class CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    fatalError("AppDelegate bulunamadı.")
                }

                persistentContainer = appDelegate.persistentContainer
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchData<T: NSManagedObject>(_ type: T.Type) -> [T]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
            return nil
        }
    }

    func deleteObject(_ object: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.delete(object)
        saveContext()
    }
}
