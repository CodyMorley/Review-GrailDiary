//
//  POIsTableViewController.swift
//  GrailDiary
//
//  Created by Ben Gohlke on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class POIsTableViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var pois: [POI] = []
    
   
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddPOIModalSegue":
            if let addVC = segue.destination as? AddPOIViewController {
                addVC.delegate = self
            }
        case "ShowPOIDetailSegue":
            if let detailVC = segue.destination as? POIDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                
                detailVC.poi = pois[indexPath.row]
            }
        default:
            print("Segue not found")
            return
        }
    }
}



extension POIsTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "POICell", for: indexPath) as? POITableViewCell else {
            fatalError("Unable to dequeue cell.")
        }
        
        cell.poi = pois[indexPath.row]
        return cell
    }
}


extension POIsTableViewController: AddPOIDelegate {
    func poiWasAdded(_ poi: POI) {
        pois.append(poi)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

