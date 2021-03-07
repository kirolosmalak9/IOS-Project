//
//  LeaguesTableViewController.swift
//  Sports
//
//  Created by Kirolos Malak on 3/1/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class LeaguesTableViewController: UITableViewController, FetchLeague {
    
    
    var leagues: Array<League> = []
    var strSport: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        tableView.register(LeaguesTableViewCell.nib(), forCellReuseIdentifier: "leagueCell")
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchLeagues()
    }
    
    func fetchLeagues() {
        print(self.strSport)
        let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php")
        
        
        request.validate().responseJSON { response in
            
            switch response.result {
            
            case .success:
                let result = try? JSON (data: response.data!)
                
                let leagues = result!["leagues"]
                
                for league in leagues.arrayValue {
                    
                    if league["strSport"].string == self.strSport {
                        
                        self.leagues.append(League(idLeague: league["idLeague"].string ?? "", strLeague: league["strLeague"].string ?? "", strSport: league["strSport"].string ?? "", strLeagueAlternate: league["strLeagueAlternate"].string ?? ""))
                    }
                }
                
                print(self.leagues[0].idLeague!)
                print(self.leagues[0].strLeague!)
                print(self.leagues[0].strSport!)
                print(self.leagues[0].strLeagueAlternate!)
                
                
                self.tableView.reloadData()
                
                
            case .failure(_):
                print("error")
            }
            
        }
        
    }
    
    func fetchLeague(league: League) -> League {
        let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(league.idLeague!)")
        
        
        
        request.validate().responseJSON { response in
            
            
            
            switch response.result {
            
            case .success:
                let result = try? JSON (data: response.data!)
                
                let leagues = result!["leagues"]
                
                for leagueDetail in leagues.arrayValue {
                    
                    league.strYoutube = leagueDetail[].string ?? ""
                    league.strBadge = leagueDetail["strBadge"].string ?? ""
                    
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                print("error")
            }
            
        }
        
        return league
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return leagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaguesTableViewCell: LeaguesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeaguesTableViewCell
        
        
        if  leagues[indexPath.row].strBadge != "" && leagues[indexPath.row].strYoutube != "" {
            leaguesTableViewCell.league = leagues[indexPath.row]
        } else {
            leaguesTableViewCell.index = indexPath.row
            leaguesTableViewCell.fetchLeague = self
            leaguesTableViewCell.leagueId = leagues[indexPath.row].idLeague
        }

        
        return leaguesTableViewCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var leaguesDetailsViewController: LeaguesDetailsViewController?
        
        leaguesDetailsViewController = self.storyboard!.instantiateViewController(withIdentifier: "leaguesDetailsViewController") as? LeaguesDetailsViewController
        
        leaguesDetailsViewController?.league = self.leagues[indexPath.row]
        self.present(leaguesDetailsViewController!, animated: true, completion: nil)
    }
    
    
    func fetchLeague(index: Int, strLeague: String, strBadge: String, strYoutube: String) {
        
        
        self.leagues[index].strLeague =  strLeague
        
        self.leagues[index].strBadge = strBadge
        
        self.leagues[index].strYoutube = strYoutube
        
    }
    
}

