//
//  Previewer.swift
//  FaceFacts
//
//  Created by Sudhir Kesharwani on 25/12/23.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person
    
    init() throws{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        
        container = try ModelContainer (for: Person.self, configurations: config)
        
        event = Event(name: "Tata Mumbai Marathon", place: "Mumbai, India")
        person = Person(name: "Abhishek Banerjee", emailAddress: "dada@blueBrigade.com", details: "Long time running friend", metAt: event)
        
        container.mainContext.insert(person)
    }
    
}
