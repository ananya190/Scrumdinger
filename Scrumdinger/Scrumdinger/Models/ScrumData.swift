//
//  ScrumData.swift
//  Scrumdinger
//
//  Created by Ananya George on 10/12/21.
//

import Foundation

class ScrumData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: false)
        } catch {
            fatalError("Can't find documents directory")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("scrums.data")
    }
    @Published var scrums: [DailyScrum] = []
    
    func load() {
        // we're going to request a global queue with a background quality of service
        // the quality of service refers to the priority of the task
        // dispatch queues are used to manage the execution of tasks serially (on the main thread) or concurrently (on a background thread)
        // dispatch queues are FIFO queues
        DispatchQueue.global(qos: .background).async { [weak self] in // here weak self is a weak reference to an instance of ScrumData?
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                // the line above loads the contents from the fileURL into a variable called data.
                // if Data(contentsOf:options) fails, the error is thrown and data is nil.
                
                // the #if DEBUG compiler directive will ensure that during development, there is sample data to work with. Code in this block is excluded from releases.
#if DEBUG
                DispatchQueue.main.async {
                    self?.scrums = DailyScrum.data
                }
#endif
                return
            }
            
            guard let dailyScrums = try? JSONDecoder().decode([DailyScrum].self, from: data) else { // decode data to form of an array composed of DailyScrums
                fatalError("Can't decode saved scrum data")
            }
            DispatchQueue.main.async {
                self?.scrums = dailyScrums
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let scrums = self?.scrums else { fatalError("Self is out of scope")}
            // the line above checks if self is in scope in the background
            guard let data = try? JSONEncoder().encode(scrums) else { fatalError("Error encoding data")}
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile) // try writing the json data to the Documents/scrum.data file
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
