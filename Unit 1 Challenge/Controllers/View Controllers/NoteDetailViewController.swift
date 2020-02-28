//
//  NoteDetailViewController.swift
//  Unit 1 Challenge
//
//  Created by Matthew Werdean on 2/28/20.
//  Copyright © 2020 Matthew Werdean. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    // MARK: - Outlets
    // Variables attached to the text field and to the text view
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextTextField: UITextView!
    
    // MARK: - Properties
    // Set a variable to check the Note array (if it exists)
    var note: Note?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Update the text and the title and note section if there is information in them when the view loads
        updateViews()
    }
    
    // MARK: - Actions
    // WHAT DO WHEN SAVE BUTTON IS TAPPED
    @IBAction func saveButtonTapped(_ sender: Any) {
        // Check to make sure there is information in the text fields
        guard let noteTitle = noteTitleTextField.text, let noteText = noteTextTextField.text else {return}
        if let note = note {
            // If `note` can take the value of `note`, then update note
            NoteController.sharedInstance.updateNote(note: note, newNoteTitle: noteTitle, newNoteText: noteText)
        } else {
            // If there is notihing inside of the note then you need to create a new one
            NoteController.sharedInstance.createNote(noteTitle: noteTitle, noteText: noteText)
        }
        // After the function is run, the page will pop back once
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    // WHAT DO WHEN CELL IS TAPPED AND YOU NEED CORRECT INFO IN TEXT FIELDS
    func updateViews() {
    // When the file is clicked on: Does this file have a note in the landing pad?
        guard let note = note else {return}
        // If so then fill in the textbox and titlebox
        noteTitleTextField.text = note.noteTitle
        noteTextTextField.text = note.noteText
    }
} // End of class
