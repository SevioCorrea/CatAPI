//
//  CatsViewController.swift
//  CatsAPI
//
//  Created by Sévio on 29/10/22.
//

import UIKit



extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


class CatsViewController: UIViewController {
    
    @IBOutlet weak var catsImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    
    var cat: CatsStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLabel.text = cat?.id
        nameLabel.text = cat?.name
        temperamentLabel.text = cat?.temperament
        //catsImage.image
        //catsImage.downloaded(from: cat!.url)
    }
}

