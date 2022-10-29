//
//  ViewController.swift
//  CatsAPI
//
//  Created by Sévio on 29/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var cats = [CatsStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if !cats.isEmpty {
            print("\(cats)")
        }
        
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let cat = cats[indexPath.row]
        cell.textLabel?.text = cat.name.capitalized
        cell.detailTextLabel?.text = cat.origin.capitalized
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // selecionar a raça na cell
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CatsViewController {
            destination.cat = cats[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if error == nil {
                do {
                    
                    self.cats = try JSONDecoder().decode([CatsStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch {
                    print("Error: \(error)")
                }
                
            }
        }.resume()
    }


}

