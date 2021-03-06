//
//  EditView.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/8/21.
//

import SwiftUI

struct EditView: View {
    @Binding var scrumData: DailyScrum.Data
    @State private var newAttendee: String = ""
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrumData.title) // the $ indicates that it's a binding to a string. a binding is a reference to a state that is owned by another state
                HStack {
                    Slider(value: $scrumData.lengthInMinutes, in: 5...30, step: 1.0) {
                        Text("Length")
                    }
                    .accessibilityValue(Text("\(Int(scrumData.lengthInMinutes)) minutes"))
                    Spacer()
                    Text("\(Int(scrumData.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ColorPicker("Color", selection: $scrumData.color)
                    .accessibilityLabel(Text("Color picker"))
            }
            Section(header: Text("Attendees")) {
                ForEach(scrumData.attendees, id:\.self) { attendee in
                    Text(attendee)
                }
                .onDelete { indices in
                    scrumData.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendee)
                    Button(action: {
                        withAnimation {
                            scrumData.attendees.append(newAttendee)
                            newAttendee = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel(Text("Add attendee"))
                    }
                    .disabled(newAttendee.isEmpty) // this disables the button when newAttendee is empty
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(scrumData: .constant(DailyScrum.data[0].data))
    }
}
