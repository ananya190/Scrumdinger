//
//  MeetingFooter.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/11/21.
//

import SwiftUI

struct MeetingFooter: View {
    var speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted}) else { return nil }
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
        // this function does three things
        // 1. creates subarray with all but the last element
        // 2. checks that all the elements in the subarray satisfy the given condition
        // 3. the given condition - each speaker's isCompleted property is true
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else {
            return "No more speakers"
        }
        return "Speaker \(speakerNumber) of \(speakers.count)"
        
    }
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                }
                else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction){
                    Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel(Text("Next Speaker"))
                }
                
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooter_Previews: PreviewProvider {
    static var speakers = [ScrumTimer.Speaker(name: "Ryan", isCompleted: false), ScrumTimer.Speaker(name: "Jonathon", isCompleted: false)]
    static var previews: some View {
        MeetingFooter(speakers: speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
