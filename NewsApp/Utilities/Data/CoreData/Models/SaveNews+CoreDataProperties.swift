//
//  SaveNews+CoreDataProperties.swift
//  NewsApp
//
//  Created by İsmail Palalı on 30.08.2023.
//
//

import Foundation
import CoreData


extension SaveNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveNews> {
        return NSFetchRequest<SaveNews>(entityName: "SaveNews")
    }

    @NSManaged public var title: String?

}

extension SaveNews : Identifiable {

}
