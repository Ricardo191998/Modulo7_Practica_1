//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Ricardo Rosales Romero on 23/09/23.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var fontValue: UIPickerView!
    
    @IBOutlet weak var fontSize: UISlider!
    
    @IBOutlet weak var noteTitle: UITextView!
    
    @IBOutlet weak var noteContent: UITextView!
    
    @IBOutlet weak var rigthButton: UIBarButtonItem!

    @IBOutlet weak var leftButton: UIBarButtonItem!

    let fontDataFamily = UIFont.familyNames.prefix(20)
       
    var newNote: Note?
    var note: Note?
    var isUpdate : Bool = false
    
    var currentFontFamily = UIFont.familyNames.first
    var currentFontSize = 15.0
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontValue.delegate = self
        fontValue.dataSource = self
        noteTitle.delegate = self
        noteContent.delegate = self
        
        noteTitle.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        noteContent.font = UIFont(name: currentFontFamily!, size: currentFontSize)
           
        rigthButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if(note == nil) {
                rigthButton.title = "Guardar"
                leftButton.title = "Cancelar"
    
            } else {
                
                rigthButton.title = "Actualizar"
                leftButton.title = "Borrar"
        
                currentFontSize = note!.fontSize
                fontSize.value = Float(currentFontSize)
                                
                currentRow = note!.fontFamilyRow

                currentFontFamily = note!.fontFamily
                
                noteTitle.text = note!.title
                noteContent.text = note!.content
                
                fontValue.selectRow(currentRow, inComponent: 0, animated: true)
            }
            
        }
    
    
    @IBAction func sizeChanged(_ sender: UISlider) {
        currentFontSize = Double(sender.value).rounded()
        noteTitle.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        noteContent.font = UIFont(name: currentFontFamily!, size: currentFontSize)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! NotesTableViewController
        
        if(note == nil){
            newNote = Note(title: noteTitle.text, content: noteContent.text , date: Date(), fontSize: currentFontSize, fontFamily: currentFontFamily!, fontFamilyRow: currentRow)
            destination.note = newNote
            destination.isUpdate = false
            isUpdate = false
            rigthButton.isEnabled = false
        } else {
            rigthButton.isEnabled = true
            note?.title = noteTitle.text
            note?.content = noteContent.text
            note?.fontSize = currentFontSize
            note?.fontFamily = currentFontFamily!
            note?.fontFamilyRow = currentRow
            
            destination.note = note
            destination.isUpdate = true
            isUpdate = true
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    func validateText(textInput: UITextView, message: String) -> Bool {
        if textInput.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                let alertController = UIAlertController(title: "Error", message:  message, preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alertController.addAction(okAction)
                   present(alertController, animated: true, completion: nil)
                return false
        }
        return true
    }

}
