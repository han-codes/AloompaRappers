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
    
    var rapper = [Rapper]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Selected Artist"
        
        print(rapper)
        artistNameLbl.text = rapper.first?.name
        descriptionLbl.text = rapper.first?.description
    }
    

    
}
