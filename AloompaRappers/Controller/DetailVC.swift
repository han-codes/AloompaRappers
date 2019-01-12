//
//  DetailVC.swift
//  AloompaRappers
//
//  Created by Hannie Kim on 1/11/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var rapper: Rapper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Selected Artist"
        
        print("RAPPER DETAILVC: \(rapper)")

        artistNameLbl.text = rapper.name
        descriptionLbl.text = rapper.description
        guard let url = URL(string: rapper.image) else { return }
        
        print("URL: \(url)")
        
        do {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
            
        } catch {
            print("Failed to get data from url")
        }
    }
    

    
}
