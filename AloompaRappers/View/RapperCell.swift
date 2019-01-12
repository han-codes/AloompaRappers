//
//  RapperCell.swift
//  AloompaRappers
//
//  Created by Hannie Kim on 1/11/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit

class RapperCell: UITableViewCell {
    @IBOutlet weak var rapperNameLbl: UILabel!
    @IBOutlet weak var rapperImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
    }
    
    func configureCell(artist: Artist) {
        self.rapperNameLbl.text = artist.artistName
        guard let artistImage = artist.image else { return }
        
        guard let url = URL(string: artistImage) else { return }
        
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
        
    }
}
