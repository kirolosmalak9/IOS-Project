//
//  TeamsDetailsViewController.swift
//  Sports
//
//  Created by Kirolos Malak on 3/7/21.
//

import UIKit
import SDWebImage

class TeamsDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
        
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var teamImageView: UIImageView!
    
    @IBOutlet weak var sportNameLabel: UILabel!
    
    @IBOutlet weak var establishedLabel: UILabel!
    
    @IBOutlet weak var stadiumLocLabel: UILabel!
    
    @IBOutlet weak var stadiumLabel: UILabel!
    
    @IBOutlet weak var subNamesLabel: UILabel!
    
    var team:Team?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.teamImageView.sd_setImage(with: URL(string: team!.image!), placeholderImage: UIImage(named: "placeholder.png"))
            
        self.navigationBar.topItem?.title = team!.teamName!
        
        self.sportNameLabel.text = team!.teamName!
        self.establishedLabel.text = team!.established!
        self.stadiumLocLabel.text = team!.stadiumLoc!
        self.stadiumLabel.text = team!.stadium!
        self.subNamesLabel.text = team!.subNames!
    }

}
