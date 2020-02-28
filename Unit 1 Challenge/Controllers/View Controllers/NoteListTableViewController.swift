//
//  NoteListTableViewController.swift
//  Unit 1 Challenge
//
//  Created by Matthew Werdean on 2/28/20.
//  Copyright © 2020 Matthew Werdean. All rights reserved.
//

import UIKit

class NoteListTableViewController: UITableViewController {
        
    // MARK: - Lifescycle

    // WHAT DO WHEN VIDEO APPEAR
    override func viewWillAppear(_ animated: Bool) {
        // Reload data every time the view appears so that it has the correct information in it
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    // FIND THE NUMBER OF ROWS IN THE SECTION
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of cells is equal to the number of items in the array
        return NoteController.sharedInstance.notes.count
    }

    // PUT INFORMATION IN THE CELLS/ROWS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Find which cells we will be using
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        // Set a contant equal to a specific note on the array
        let note = NoteController.sharedInstance.notes[indexPath.row]
        
        // Attach the title and text to the cell
        cell.textLabel?.text = note.noteTitle
        cell.detailTextLabel?.text = note.noteText
        return cell
    }

    // DELETE THE CORRECT ROW IN THE SECTION
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Find what note the user is trying to delete
            let noteToDelete = NoteController.sharedInstance.notes[indexPath.row]
            // Delete it
            NoteController.sharedInstance.deleteNote(note: noteToDelete)
            // Remove note from tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Reference the specific segue that you want
        if segue.identifier == "toDetailVC" {
            // Check to see what the index path is that was clicked on
            guard let indexPath = tableView.indexPathForSelectedRow,
                // Make sure the destination is set correctly
                let destinationVC = segue.destination as? NoteDetailViewController else {return}
            // Declare constant on the correct note we need to send
            let noteToSend = NoteController.sharedInstance.notes[indexPath.row]
            // Attach it to destinationVC
            destinationVC.note = noteToSend
        }
    }
}// End of class
