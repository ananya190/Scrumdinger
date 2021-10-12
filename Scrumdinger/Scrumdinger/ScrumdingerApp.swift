//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/8/21.
//

import SwiftUI

@main
struct ScrumdingerApp: App { // the structure conforms to the App protocol
    @ObservedObject private var data = ScrumData() // creating object of ScrumData
    // according to the code in the definition of the object, you start with an empty array of DailyScrums and then when the load function is called, the data from Document/scrum.data is loaded into the object
    var body: some Scene { // returns a Scene that contains the view heirarchy representing the primary user interface for the app
        WindowGroup { // views added here are presented in a window that fills the entire screen
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
