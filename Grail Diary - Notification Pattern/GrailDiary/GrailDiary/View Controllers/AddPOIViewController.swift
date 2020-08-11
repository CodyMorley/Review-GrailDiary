//
//  AddPOIViewController.swift
//  GrailDiary
//
//  Created by Ben Gohlke on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AddPOIViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var clue1TextField: UITextField!
    @IBOutlet weak var clue2TextField: UITextField!
    @IBOutlet weak var clue3TextField: UITextField!
   
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    
    //MARK: Actions
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let location = locationTextField.text,
            let country = countryTextField.text,
            !location.isEmpty,
            location != "",
            !country.isEmpty,
            country != "" else {
            return
        }
        
        var newPOI = POI(location: location,
                         country: country,
                         clues: [])
        
        if let clue1 = clue1TextField.text,
            !clue1.isEmpty,
            clue1 != "" {
                newPOI.clues.append(clue1)
        }
        
        if let clue2 = clue2TextField.text,
            !clue2.isEmpty,
            clue2 != "" {
                newPOI.clues.append(clue2)
        }
        
        if let clue3 = clue3TextField.text,
            !clue3.isEmpty,
            clue3 != "" {
                newPOI.clues.append(clue3)
        }
        //TODO: Replace below with notification
        let userInfo = ["newPOI" : newPOI]
        NotificationCenter.default.post(name: .newPOI,
                                        object: nil,
                                        userInfo: userInfo)
        dismiss(animated: true,
                completion: nil)
    }
    
    
    //MARK: Methods
    private func setDelegates() {
        locationTextField.delegate = self
        countryTextField.delegate = self
        clue1TextField.delegate = self
        clue2TextField.delegate = self
        clue3TextField.delegate = self
    }
}


extension AddPOIViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
        !text.isEmpty,
        text != "" else { return false }
        
        
        switch textField {
        case locationTextField:
            countryTextField.becomeFirstResponder()
        case countryTextField:
            clue1TextField.becomeFirstResponder()
        case clue1TextField:
            clue2TextField.becomeFirstResponder()
        case clue2TextField:
            clue3TextField.becomeFirstResponder()
        case clue3TextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}
