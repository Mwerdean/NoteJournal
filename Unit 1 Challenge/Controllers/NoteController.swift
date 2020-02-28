//
//  QuoteController.swift
//  Unit 1 Challenge
//
//  Created by Matthew Werdean on 2/28/20.
//  Copyright © 2020 Matthew Werdean. All rights reserved.
//

import Foundation

class NoteController {
    // MARK: - Properties
    
    // Source of Truth
    var notes: [Note] = []
    
    // Shared instance, singleton
    static let sharedInstance = NoteController()
    
    // Load info on startup
    init() {
        loadFromPersistence()
    }
    
    // MARK: - CRUD Functions
    
    // Create a new note
    func createNote(noteTitle: String, noteText: String) {
        // Create the note
        let note = Note(noteTitle: noteTitle, noteText: noteText)
        // Add the note to our source of truth
        notes.append(note)
        // Save to storage
        saveToPersistentStorage(notes: notes)
    }
    
    // Update an existing note
    func updateNote(note: Note, newNoteTitle: String, newNoteText: String) {
        note.noteTitle = newNoteTitle
        note.noteText = newNoteText
        // Save to storage
        saveToPersistentStorage(notes: notes)
    }
    
    // Delete an existing note
    func deleteNote(note: Note) {
        // Make sure note is attached
        guard let index = notes.firstIndex(of: note) else  {return}
        notes.remove(at: index)
        // Save to storage
        saveToPersistentStorage(notes: notes)
    }
    
    //MARK: - Persistence
    // COPY PASTE THIS BAD BOY FROM YOUR SNIPPET
    
    // CREATE A NEW URL
    func fileURL() -> URL {
        // Find a default url in the file manager
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Set a file name
        let fileName = "notekeeper.json"
        // Set a directory equal to the first spot you found in the filemanager
        let documentDirectory = urls[0]
        // Append the filed name we created to the directory
        let documentsDirectoryURL = documentDirectory.appendingPathComponent(fileName)
        // Return that bish
        return documentsDirectoryURL
    }
    
    // ENCODE THE INFORMATION AND THROW INTO THE FILE WE CREATED ABOVE
    func saveToPersistentStorage(notes: [Note]) {
        // Set a constant to JSONEncoder and call it (or what swifties say, initialize it)
        let encoder = JSONEncoder()
        // Do, try, catch
        do {
            // Set a constant to try and encode the notes
            let data = try encoder.encode(notes)
            // Write the file to the URL we created above
            try data.write(to: fileURL())
        } catch let error {
            // If any of the tries fail let us know. Also in the future, you probably want better error handling
            print("There was an error saving to persistent storage: \(error)")
        }
    }
    
    // PULL THE INFORMATION OUT, DECODE IT, AND ATTACH IT TO THE SOURCE OF TRUTH
    func loadFromPersistence() {
        // Set a constant to JSONDecoder
        let jsonDecoder = JSONDecoder()
        // Do, try, catch
        do {
            // See if the url is created above and get the contents of it
            let data = try Data(contentsOf: fileURL())
            // Set a contant and try to decode notes we pulled from data
            let decodedData = try jsonDecoder.decode([Note].self, from: data)
            // Set the source of truth to the data
            self.notes = decodedData
        } catch let error {
            // If any of the tries fail let us know. Also in the future, you probably want better error handling
            print("\(error.localizedDescription) -> \(error)")
        }
    }
}
