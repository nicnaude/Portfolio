//
//  ProjectPhoto+CoreDataProperties.swift
//  Portfolio
//
//  Created by Nicholas Naudé on 14/02/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProjectPhoto {

    @NSManaged var photoImage: NSData?
    @NSManaged var photoDescription: String?
    @NSManaged var owned: NSSet?

}
