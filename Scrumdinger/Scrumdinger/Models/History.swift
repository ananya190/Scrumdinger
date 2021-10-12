//
//  History.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/12/21.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [String]
    var lengthInMinutes: Int
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript:String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
    
}
