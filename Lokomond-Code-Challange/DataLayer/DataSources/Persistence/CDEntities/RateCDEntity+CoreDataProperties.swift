//
//  RateCDEntity+CoreDataProperties.swift
//  Lokomond-Code-Challange
//
//  Created by Kiarash Vosough on 5/9/23.
//
//

import Foundation
import CoreData


extension RateCDEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RateCDEntity> {
        return NSFetchRequest<RateCDEntity>(entityName: "RateCDEntity")
    }

    @NSManaged public var price: Double
    @NSManaged public var symbol: String?

}

extension RateCDEntity : Identifiable {

}
