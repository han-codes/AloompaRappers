//
//  RapperCell.swift
//  AloompaRappers
//
//  Created by Hannie Kim on 1/11/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit

class RapperCell: UITableViewCell {
    @IBOutlet weak var rapperNamLbl: UILabel!
    @IBOutlet weak var rapperImage: UIImageView!
    
    private var rapper: Rapper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(rapper: Rapper) {
        self.rapper = rapper
        
        rapperNamLbl.text = rapper.name
        print("NAME: \(rapper.name)")
        
        guard let url = URL(string: rapper.image) else { return }

        print("URL: \(url)")
        
        do {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.rapperImage.image = UIImage(data: data)
                    }
                }
            }
            
        } catch {
            print("Failed to get data from url")
        }
        
        
//                let data = try? Data(contentsOf: url)
        //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        
//        UIImage(data: <#T##Data#>)
//        UIImage(contentsOfFile: <#T##String#>)
//        rapperImage.image = UIImage(named: rapper.image)
    }
}
