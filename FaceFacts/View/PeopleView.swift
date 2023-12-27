//
//  PeopleView.swift
//  FaceFacts
//
//  Created by Sudhir Kesharwani on 25/12/23.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
    
    @Query var people: [Person]
    @Environment(\.modelContext) var modelContext

    var body: some View {
        List{
            ForEach(people){person in
                
                NavigationLink(value: person){
                    Text(person.name)
                }
            }
            .onDelete(perform: deletePerson)
        }
    }
    
    init(searchString: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        _people = Query(filter: #Predicate { person in
            
            if searchString.isEmpty{
                true
            }else {
                person.name.localizedStandardContains(searchString)
                || person.emailAddress.localizedStandardContains(searchString)
                || person.details.localizedStandardContains(searchString)
            }
         },sort: sortOrder)
    }
    
    func deletePerson(at offsets: IndexSet)  {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

    #Preview {
        
        do{
            let previewer = try Previewer()
            
            return PeopleView().modelContainer(previewer.container)
        }catch{
            return Text("Unable to create preview for this view: \(error.localizedDescription)")
        }
    }
