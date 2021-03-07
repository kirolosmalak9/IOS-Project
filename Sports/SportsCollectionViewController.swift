//
//  SportsCollectionViewController.swift
//  Sports
//
//  Created by Kirolos Malak on 2/28/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage


class SportsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    var sports: Array<Sport> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchLeagues()
    }
    
    func fetchLeagues(){
        sports = []
        let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
        
        
        
        request.validate().responseJSON { response in
            
            switch response.result {
            
                case .success:
                    let result = try? JSON (data: response.data!)
                    
                    let sports = result!["sports"]
                    
                    for sport in sports.arrayValue {
                   
                        self.sports.append(Sport(idSport: sport["idSport"].string ?? "", strSport: sport["strSport"].string ?? "", strFormat: sport["strFormat"].string ?? "", strSportThumb: sport["strSportThumb"].string ?? "", strSportDescription: sport["strSportDescription"].string ?? ""))
                    }
                    
                    
                    self.collectionView.reloadData()
                    
                    

            case .failure(_):
                print("error")
            }
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var leaguesTableViewController: LeaguesTableViewController?
        
        if sports.count > 0 && sports.count > indexPath.row {
            leaguesTableViewController = self.storyboard!.instantiateViewController(withIdentifier: "leaguesTableViewController") as? LeaguesTableViewController

            leaguesTableViewController?.strSport = self.sports[indexPath.row].strSport!
            leaguesTableViewController?.leagues = []
            self.present(leaguesTableViewController!, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        let imageView: UIImageView = cell.viewWithTag(1) as! UIImageView
        let label: UILabel = cell.viewWithTag(2) as! UILabel

        if sports.count > 0 && sports.count > indexPath.row {
            imageView.sd_setImage(with: URL(string: sports[indexPath.row].strSportThumb!), placeholderImage: UIImage(named: "placeholder.png"))
            
            label.text = sports[indexPath.row].strSport!  
        }
        
        
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.backgroundColor = UIColor(red: 197/255, green: 98/255, blue: 0, alpha: 1)

                    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        return CGSize(width: collectionView.frame.width / 2  , height: collectionView.frame.width / 2 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
    }
    
}
