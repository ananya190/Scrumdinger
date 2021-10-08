//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/8/21.
//

import SwiftUI

@main
struct ScrumdingerApp: App { // the structure conforms to the App protocol
    var body: some Scene { // returns a Scene that contains the view heirarchy representing the primary user interface for the app
        WindowGroup { // views added here are presented in a window that fills the entire screen
            NavigationView {
                ScrumsView(scrums: DailyScrum.data)
            }
        }
    }
}
