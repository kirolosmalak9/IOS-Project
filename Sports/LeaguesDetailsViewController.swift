//
//  LeaguesDetailsViewController.swift
//  Sports
//
//  Created by Kirolos Malak on 3/6/21.
//

import UIKit
import CoreData

class LeaguesDetailsViewController: UIViewController {
    
    var league: League?
    var leagueIsFavorite = false

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var upComingEventsView: UpComingEventsView!
    
    @IBOutlet weak var lastestResultsView: LastestResultsView!
    
    @IBOutlet weak var teamsView: TeamsView!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.topItem?.title = league!.strLeague
        if checkLeagueIsFavorite() != 0 {
            leagueIsFavorite = true
            favoriteBarButtonItem.image = (UIImage (systemName: "star.fill"))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let league = league {
            self.upComingEventsView!.leagueId = league.idLeague!
            self.lastestResultsView!.leagueId = league.idLeague!
            self.teamsView.uiViewController = self
            self.teamsView!.leagueId = league.idLeague!
        }
    }
    
    
    
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    @IBAction func AddLeaguesToFavorite(_ sender: UIBarButtonItem) {
        
        if !leagueIsFavorite {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let leagueEntity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: context)
            let newLeague = NSManagedObject(entity: leagueEntity!, insertInto: context)

            
            newLeague.setValue(league?.idLeague, forKey: "idLeague")
            newLeague.setValue(league?.strLeague, forKey: "strLeague")
            newLeague.setValue(league?.strSport, forKey: "strSport")
            newLeague.setValue(league?.strLeagueAlternate, forKey: "strLeagueAlternate")
            newLeague.setValue(league?.strYoutube, forKey: "strYoutube")
            newLeague.setValue(league?.strBadge, forKey: "strBadge")
            
            do {
                try context.save()
                leagueIsFavorite = true
                favoriteBarButtonItem.image = (UIImage (systemName: "star.fill"))
            } catch {
                print("error context.save()")
            }
        } else {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")
            request.predicate = NSPredicate(format: "idLeague == %@", (league?.idLeague)! as NSString)
            
            do {
                let result = try context.fetch(request)
                for data in result {
                    context.delete(data as! NSManagedObject)
                }
                try context.save()
                leagueIsFavorite = false
                favoriteBarButtonItem.image = (UIImage (systemName: "star"))
            } catch {
                print("error context.fetch()")
            }
        }
    }
    
    func checkLeagueIsFavorite () -> Int {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")

        request.predicate = NSPredicate(format: "idLeague == %@", (league?.idLeague)! as NSString)
        
        request.resultType = NSFetchRequestResultType.countResultType

        var result = 0
        
        do {
            result = try context.count(for: request)
        } catch {
            print("error context.fetch()")
        }
        
        return result
    }
    
}
