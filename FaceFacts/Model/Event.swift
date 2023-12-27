//
//  Event.swift
//  FaceFacts
//
//  Created by Sudhir Kesharwani on 25/12/23.
//

import Foundation
import SwiftData

@Model
class Event{
    var name: String
    var place: String
    var people = [Person]()
    
    init(name: String, place: String) {
        self.name = name
        self.place = place
    }
    
}
