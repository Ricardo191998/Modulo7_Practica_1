//
//  ViewControllerExtension.swift
//  Notes
//
//  Created by Ricardo Rosales Romero on 30/09/23.
//

import UIKit

//MARK: UIPickerViewDataSource methods implementacion
extension AddNoteViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fontDataFamily.count
    }
}

//MARK: UIPickerViewDelegate  methods implemetation
extension AddNoteViewController : UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fontDataFamily[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentFontFamily = fontDataFamily[row]
        currentRow = row
        noteTitle.font = UIFont(name: currentFontFamily!, size: currentFontSize)
        noteContent.font = UIFont(name: currentFontFamily!, size: currentFontSize)
    }
}

extension AddNoteViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        print("Text changed!")
        if(!validateText(textInput: noteTitle, message: "Favor de llenar el titulo") || !validateText(textInput: noteContent, message: "Favor de llenar el contenido") ) {
            
            rigthButton.isEnabled = false
        } else {
            rigthButton.isEnabled = true
        }
    }
    
    /*
     }*/
}

