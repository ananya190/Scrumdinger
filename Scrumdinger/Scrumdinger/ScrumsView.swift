//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/8/21.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented: Bool = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    EditView(scrumData: $newScrumData)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: { isPresented = false }) {
                                    Text("Dismiss")
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    let newScrum = DailyScrum( title: newScrumData.title, attendees: newScrumData.attendees, lengthInMinutes: Int(newScrumData.lengthInMinutes), color: newScrumData.color)
                                    scrums.append(newScrum)
                                    isPresented = false
                                }) {
                                    Text("Add")
                                }
                            }
                        }
                }
                
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isPresented = true }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else { fatalError("Can't find scrum in array") }
        return $scrums[scrumIndex] // $ accesses the projected value of the wrapped property (in this case scrums[scrumIndex]. the projected value itself is a binding (it can read and write the properties of the variable)
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
