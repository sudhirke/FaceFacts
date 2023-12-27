//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by Sudhir Kesharwani on 24/12/23.
//
import PhotosUI
import SwiftUI
import SwiftData

struct EditPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var person : Person
    @Binding var navigationPath: NavigationPath
    @State private var selectedItem: PhotosPickerItem?
    
    //define query for events
    @Query(sort:[
        SortDescriptor(\Event.name),
        SortDescriptor(\Event.place)
    ]) var events: [Event]
    
    var body: some View {
        
        Form
        {
            Section("Person"){
                
                //generate preview of photo if it contains data
                if let imageData = person.photo,
                    let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                PhotosPicker(selection: $selectedItem, matching: .images){
                    Label("Select a photo",systemImage: "person")
                }
            }
            Section("Person"){
                TextField("Name",text: $person.name)
                    .textContentType(.name)
                TextField("Email",text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
       
            }
            
            Section("Where did you meet:"){
                Picker("Met at", selection: $person.metAt){
                    Text("Unknown event")
                        .tag(Optional<Event>.none)
                    
                    if events.isEmpty == false{
                        Divider()
                        
                        ForEach(events){event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }
                Button("Add Event", action: addEvent)
                
            }
            
            Section("Notes"){
                TextField("Details",text: $person.details,axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self){ event in
            EditEventView(event: event)
        }
        .onChange(of: selectedItem,loadPhoto)
        
    }
    
    func addEvent(){
        let event = Event(name: "", place: "")
        modelContext.insert(event)
        navigationPath.append(event)
    }
    
    //load person
    func loadPhoto(){
        Task{@MainActor in
            person.photo = try await
                selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    
    do{
        let previewer = try Previewer()
        
        return EditPersonView(person: previewer.person, navigationPath: .constant(NavigationPath())).modelContainer(previewer.container)
        
    }catch{
        return Text("Failed to create preview:\(error.localizedDescription)")
    }
}
