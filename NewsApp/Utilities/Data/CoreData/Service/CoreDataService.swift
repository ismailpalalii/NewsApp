//
//  CoreDataService.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//

import CoreData

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    func saveNewsItem(title: String)
    func removeNewsItem(title: String)
    func fetchNewsItem(withTitle title: String) -> SaveNews?
}

class CoreDataService: CoreDataServiceProtocol {

    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveNewsItem(title: String) {
        let newItem = SaveNews(context: context)
        newItem.title = title

        saveContext()
    }

    func removeNewsItem(title: String) {
        if let existingItem = fetchNewsItem(withTitle: title) {
            context.delete(existingItem)
            saveContext()
        }
    }

    func fetchNewsItem(withTitle title: String) -> SaveNews? {
        let fetchRequest: NSFetchRequest<SaveNews> = SaveNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching news item: \(error)")
            return nil
        }
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



