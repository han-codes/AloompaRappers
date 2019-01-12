//
//  ViewController.swift
//  AloompaRappers
//
//  Created by Hannie Kim on 1/11/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var rappers = [Rapper]()
    var passedRapper: Rapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Select an Artist"
        
        parseJSON()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.estimatedRowHeight = 120
//        tableView.rowHeight = UITableView.automaticDimension
//    }
    
    func parseJSON() {
        
        let jsonUrlString = "http://assets.aloompa.com.s3.amazonaws.com/rappers/rappers.json"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from url: ", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    
                    let websiteDescription = try JSONDecoder().decode(WebDescription.self, from: data)
                    print(websiteDescription.artists)
                    
                    
                    for i in 0 ... websiteDescription.artists.count - 1 {
                        self.rappers.append(websiteDescription.artists[i])
                    }
                    self.tableView.reloadData()
                    
                    print("🙌🏻RAPPER: \(self.rappers)")
                    
                } catch let jsonError{
                    print("Failed to decode: ", jsonError)
                }
            }
        }.resume()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_DETAILVC {
            if let destinationVC = segue.destination as? DetailVC {
                destinationVC.rapper = passedRapper
            }
        }
        
    }
}


extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rappers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rapperCell", for: indexPath) as? RapperCell else { return UITableViewCell() }
        cell.configureCell(rapper: rappers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        print(rappers[indexPath.row])
        passedRapper = rappers[indexPath.row]
        
        performSegue(withIdentifier: TO_DETAILVC, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
