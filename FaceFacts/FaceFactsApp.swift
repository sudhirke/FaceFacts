//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Sudhir Kesharwani on 24/12/23.
//

import SwiftUI
import SwiftData

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
