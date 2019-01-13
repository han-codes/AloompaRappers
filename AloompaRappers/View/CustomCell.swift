//
//  CustomCell.swift
//  AloompaRappers
//
//  Created by Hannie Kim on 1/12/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(artist: Artist) {
        self.artistNameLbl.text = artist.artistName
        guard let artistImage = artist.image else { return }
        
        guard let url = URL(string: artistImage) else { return }
        
        do {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.artistImageView.image = UIImage(data: data)
                    }
                }
            }
        } catch {
            print("Failed to get data from url")
        }
    }
}
