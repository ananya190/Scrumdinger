//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/11/21.
//

import Foundation

class ScrumTimer: ObservableObject { // SwiftUI's views watch this class for changes. properties marked published, when they change, make all the views that use this class reload
    
    struct Speaker: Identifiable {
        let name: String
        var isCompleted: Bool
        let id = UUID()
    }
    
    @Published var activeSpeaker: String = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    
    var speakers: [Speaker] = []
    
    var lengthInMinutes: Int
    
    var speakerChangedAction: (() -> Void)?
    
    private var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate: Date?
    
    init(lengthInMinutes: Int = 0, attendees: [String] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.isEmpty ? [Speaker(name: "Player 1", isCompleted: false)] : attendees.map { Speaker(name: $0, isCompleted: false) }
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
        
    
}
