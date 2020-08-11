//
//  POIDetailViewController.swift
//  GrailDiary
//
//  Created by Ben Gohlke on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class POIDetailViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cluesTextView: UITextView!
    
    var poi: POI?
    
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    //MARK: Methods
    private func updateViews() {
        guard let poi = poi else { return }
        var clueString = """
        Clues:
        
        """
        
        for clue in poi.clues {
            clueString.append("""
                
                \(clue)
                """)
        }
        
        locationLabel.text = poi.location
        countryLabel.text = poi.country
        cluesTextView.text = clueString
    }
    
}
