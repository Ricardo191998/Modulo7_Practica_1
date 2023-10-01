//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Ricardo Rosales Romero on 22/09/23.
//

import UIKit

class NotesTableViewController: UITableViewController {

    @IBOutlet var emptyNoteView: UIView!
    let noteManager = NoteManager()
    @IBOutlet var notesTableView: UITableView!
    
    var selectNote : Note?
    var note : Note?
    var isUpdate: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectNote = nil
        
        showBackGround()
    }
    
    func showBackGround() {
        if noteManager.countNotes() == 0{
            emptyNoteView.isHidden = false
            notesTableView.backgroundView = emptyNoteView
        } else {
            emptyNoteView.isHidden = true
            notesTableView.backgroundView = UIView()
            noteManager.loadNotes()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return noteManager.countNotes()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteViewCell
                
        let note = noteManager.getNote(at: indexPath.row)
                
        cell.title.text = note.title
        
        cell.detail.text = note.content
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectNote = noteManager.getNote(at: indexPath.row)
            //print(selectPokemon?.name)
            self.performSegue(withIdentifier: "detailSegue", sender: Self.self)
    }

    
    func createObject() -> Note? {
        return nil
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == nil){
            let destination = segue.destination as! UINavigationController
        } else {
            let destination = segue.destination as! AddNoteViewController
            destination.note = selectNote
        }
        
    }
    
    @IBAction func unWindFromAddNoteController(segue: UIStoryboardSegue){
        
        
        let source = segue.source as! AddNoteViewController
        
        if(source.isUpdate){
            noteManager.deleteNote(at: notesTableView.indexPathForSelectedRow!.row)
            
            noteManager.saveNotes()
            tableView.reloadData()
            
            showBackGround()
        }
        
    }
    
    @IBAction func saveNoteFromAddNoteController(segue: UIStoryboardSegue){
        
        let source = segue.source as! AddNoteViewController
        note = source.newNote
        
        if(!source.isUpdate){
            note = source.newNote
            noteManager.createNote(note: note!)
        } else {
            note = source.note
            noteManager.updateNote(note: note!, at: notesTableView.indexPathForSelectedRow!.row)
        }
        
        noteManager.saveNotes()
        tableView.reloadData()
        
        selectNote = nil
        
        showBackGround()
        
    }
    

}
