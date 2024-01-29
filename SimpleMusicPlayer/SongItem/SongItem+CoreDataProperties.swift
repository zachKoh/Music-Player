//
//  SongItem+CoreDataProperties.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 29/01/2024.
//
//

import Foundation
import CoreData


extension SongItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SongItem> {
        return NSFetchRequest<SongItem>(entityName: "SongItem")
    }

    @NSManaged public var songName: String?
    @NSManaged public var albumName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var imageName: String?

}

extension SongItem : Identifiable {

}
