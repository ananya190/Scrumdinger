//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/11/21.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    private var progress: Double {
        guard secondsRemaining > 0 else { return 1}
        let totalSeconds = Double(secondsElapsed + secondsRemaining)
        return Double(secondsElapsed) / totalSeconds
    }
    private var minutesRemaining: Int {
        return secondsRemaining / 60
    }
    private var minutesRemainingMetric: String {
        return minutesRemaining == 1 ? "minute" : "minutes"
    }
    let scrumColor: Color
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(scrumColor: scrumColor))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    HStack {
                        Text("\(secondsRemaining)")
                        Image(systemName: "hourglass.tophalf.fill")
                    }
                }
            }
            
        }
        .accessibilityElement(children: .ignore) // ignores the accessibility elements and values for child views of HStack
        .accessibilityLabel(Text("Time Remaining")) // adds single label for HStack
        .accessibilityValue(Text("\(minutesRemaining) \(minutesRemainingMetric)"))
        .padding([.top, .horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 300, secondsRemaining: 600, scrumColor: DailyScrum.data[0].color)
            .previewLayout(.sizeThatFits)
    }
}
