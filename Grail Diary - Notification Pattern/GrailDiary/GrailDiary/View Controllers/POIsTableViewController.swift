//
//  POIsTableViewController.swift
//  GrailDiary
//
//  Created by Ben Gohlke on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class POIsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pois: [POI] = []
    
    
    //MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setObservers()
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddPOIModalSegue":
            if let addVC = segue.destination as? AddPOIViewController {
                print("using modal segue to \(addVC)")
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
    
    
    //MARK: Methods
    private func setObservers() {
        NotificationCenter.default.addObserver(forName: .newPOI,
                                               object: nil,
                                               queue: .main,
                                               using: newPOI)
    }
    
    private func newPOI(notification: Notification) {
        if let userInfo = notification.userInfo,
            let newPOI = userInfo["newPOI"] as? POI {
            
            pois.append(newPOI)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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

