//
//  EditEventView.swift
//  FaceFacts
//
//  Created by Sudhir Kesharwani on 25/12/23.
//

import SwiftUI

struct EditEventView: View {
    
    @Bindable var event: Event
    
    var body: some View {
        Form{
            TextField("Name of event", text: $event.name)
            TextField("Location", text: $event.place)
        }
        .navigationTitle("Edit Event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    
    do{
        let previewer = try Previewer()
        
        return EditEventView(event: previewer.event).modelContainer(previewer.container)
        
    }catch{
        return Text("Failed to create preview:\(error.localizedDescription)")
    }
}
