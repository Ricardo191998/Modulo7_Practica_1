//
//  NoteDataManager.swift
//  Notes
//
//  Created by Ricardo Rosales Romero on 22/09/23.
//

import Foundation

class NoteManager{
    private var notes: [Note] = []
    
    init(){
        loadNotes()
    }
    
    func createNote(note: Note){
        notes.append(note)
    }
    
    func deleteNote(at index: Int){
        notes.remove(at: index)
    }
    
    func countNotes () -> Int {
        return notes.count
    }
    
    func getNote(at index: Int) -> Note {
        return notes[index]
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func getFilePath() -> URL{
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            let noteUrlPath = documentDirectory.appendingPathComponent("notes.json")
            
            return URL(string: noteUrlPath.absoluteString)!
    }
    
    func loadNotes(){
        
        let fileManager = FileManager.default
        let notesPath = getFilePath()
        
        if fileManager.fileExists(atPath: notesPath.path){
            
            do{
                let jsonData = fileManager.contents(atPath: notesPath.path)
                print("notas: ", jsonData)
                if let jsonString = String(data: jsonData!, encoding: .utf8) {
                        print(jsonString)
                    }
                notes = try JSONDecoder().decode([Note].self, from: jsonData!)
                print("notes:", notes)
            } catch let error {
                print(error)
            }
            
        } else {
            print("MSG: Files does not exist")
        }
        
    }
    
    func saveNotes(){
        let fileManager = FileManager.default
        let notesPath = getFilePath()
        
        do{
           
            let jsonData = try JSONEncoder().encode(notes)
            fileManager.createFile(atPath: notesPath.path, contents: jsonData)
            
        }catch let error{
            print(error)
        }
        
    }
    
    func updateNote(note: Note, at index: Int){
        notes[index] = note
    }
    
}
