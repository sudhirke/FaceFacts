//
//  ContentView.swift
//  FaceFacts
//
//  Created by Sudhir Kesharwani on 24/12/23.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path =  NavigationPath()
    @State private var sortOrder = [SortDescriptor(\Person.name)]
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path){
            PeopleView(searchString: searchText, sortOrder: sortOrder)
                .navigationTitle("FaceFacts")
                .navigationDestination(for: Person.self){person in
                    EditPersonView(person: person, navigationPath: $path)
                }
                .toolbar{
                    Menu("Sort",systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder){
                            Text("Name Ascending")
                                .tag([SortDescriptor(\Person.name)])
                            Text("Name Descending")
                                .tag([SortDescriptor(\Person.name,order:.reverse)])
                            
                            Text("Email Ascending")
                                .tag([SortDescriptor(\Person.emailAddress)])
                            Text("Email Descending")
                                .tag([SortDescriptor(\Person.emailAddress,order:.reverse)])
                        }
                    }
                    Button("Add Person",systemImage: "person.fill",action: addPerson)
                }
                .searchable(text: $searchText)
        }
    }
    
    func addPerson(){
        let person = Person(name: "", emailAddress: "", details: "")
        modelContext.insert(person)
        path.append(person)
    }
    

}

#Preview {
    
    do{
        let previewer = try Previewer()
        
        return ContentView().modelContainer(previewer.container)
    }catch{
        return Text("Unable to create preview for this view: \(error.localizedDescription)")
    }
}
