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
    var passedArtist: Artist?
    var artists = [Artist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Select an Artist"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        parseJSON()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreDataObjects()
        
        if artists.count <= 0 {
            save(rapper: rappers)
        } else {
            print("🤬 ARTISTS IS NOT EMPTY, SO DON'T SAVE")
        }
        tableView.reloadData()
    }
    
    // Mark: Fetch Core Data Objects
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if artists.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    // Mark: Parse JSON & Append to Array
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
                    //                    print(websiteDescription.artists)
                    for i in 0 ... websiteDescription.artists.count - 1 {
                        self.rappers.append(websiteDescription.artists[i])
                    }
                } catch let jsonError{
                    print("Failed to decode: ", jsonError)
                }
            }
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_DETAILVC {
            if let destinationVC = segue.destination as? DetailVC {
                destinationVC.artist = passedArtist
            }
        }
    }
}


extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rapperCell", for: indexPath) as? RapperCell else { return UITableViewCell() }
        cell.configureCell(artist: artists[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        passedArtist = artists[indexPath.row]
        performSegue(withIdentifier: TO_DETAILVC, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// Mark: Core Data CRUD Methods
extension MainVC {
    func save(rapper: [Rapper]) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let artist = Artist(context: managedContext)
        
        for i in 0 ... rapper.count - 1 {
            artist.id = rapper[i].id
            artist.artistName = rapper[i].name
            artist.artistDescription = rapper[i].description
            artist.image = rapper[i].image
        }
        
        do {
            try managedContext.save()
            print("🙌🏻Successfully saved data")
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ success: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Artist>(entityName: "Artist")
        let sort = NSSortDescriptor(key: "artistName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        do {
            artists = try managedContext.fetch(fetchRequest)
            print("💪🏻 Successfully fetched data")
            completion(true)
        } catch {
            debugPrint("\(error.localizedDescription)")
            completion(false)
        }
    }
}
