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
    
    var artist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Selected Artist"
        
        print("RAPPER DETAILVC: \(artist)")

        artistNameLbl.text = artist.artistName
        descriptionLbl.text = artist.artistDescription
        guard let url = URL(string: artist.image!) else { return }
        
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
