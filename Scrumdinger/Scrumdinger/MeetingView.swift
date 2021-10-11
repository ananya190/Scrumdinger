//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/8/21.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}){
                    Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel(Text("Next Speaker"))
                }
            }
            
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
