//
//  SavedLeagueViewController.swift
//  SportApp
//
//  Created by ahmed on 02/02/2023.
//

import UIKit
import Reachability
import Kingfisher
import TTGSnackbar

class FavouriteLeaguesViewController: UIViewController {
    
    @IBOutlet weak var savedLeagueTable: UITableView!
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var savedLeagueArray = [League]()
    private let favouriteViewModel = FavouriteLeaguesVM()
    private var deletedLeagueItem : League?
    var urlHelper: URLHelper = URLHelper(endPoint: "" , leagueId: 0)
    private var flag : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        savedLeagueTable.delegate = self
        savedLeagueTable.dataSource = self
        configurationNibFile()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getSavedLeagues()
    }
    
    func configurationNibFile(){
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        savedLeagueTable.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension FavouriteLeaguesViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return "Saved Leagues"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedLeagueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.cellTitle.text = savedLeagueArray[indexPath.row].league_name
        
        let url = URL(string: (savedLeagueArray[indexPath.row].league_logo ?? "https://m.media-amazon.com/images/M/MV5BZDc4MzVkNzYtZTRiZC00ODYwLWJjZmMtMDIyNjQ1M2M1OGM2XkEyXkFqcGdeQXVyMDA4NzMyOA@@._V1_Ratio0.6716_AL_.jpg" ))
        cell.cellImage?.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            deleteLeaueItem(indexPath: indexPath)
        
    }
}

extension FavouriteLeaguesViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        urlHelper = URLHelper(endPoint:savedLeagueArray[indexPath.row].League_endpoint , leagueId: savedLeagueArray[indexPath.row].league_key)
        validateNavigation()
    }
}


extension FavouriteLeaguesViewController : IRenderView {
    
    func getSavedLeagues(){
        favouriteViewModel.fetchSavedLeagues(appDelegate: self.appDelegate)
        savedLeagueArray = favouriteViewModel.savedLeaguesArray ?? []
        favouriteViewModel.bindingData = {result , error in
            if result != nil {
                self.renderView()
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func renderView(){
        self.savedLeagueArray  = self.favouriteViewModel.savedLeaguesArray ?? []
            DispatchQueue.main.async {
                self.savedLeagueTable.reloadData()
            }
    }
    
    func deleteLeaueItem(indexPath: IndexPath){
        if (favouriteViewModel.error == nil)
        {
            DispatchQueue.main.async { [self] in
                deletedLeagueItem = self.savedLeagueArray[indexPath.row]
                savedLeagueArray.remove(at: indexPath.row)
                self.savedLeagueTable.deleteRows(at: [indexPath], with: .automatic)
                // savedLeagueTable.reloadData()
                if let name = deletedLeagueItem?.league_name
                {
                    let successMsg = "\(String(describing: name)) was unsaved successfully"
                    showSuccessSnakbar(msg: successMsg , index: indexPath.row )
                    DispatchQueue.main.asyncAfter(deadline: .now()+5){
                        if self.flag == true {
                            self.favouriteViewModel.deleteLeagueItemFromFavourites(appDeleget: self.appDelegate, leagueKey: self.deletedLeagueItem?.league_key ?? -1)
                        }
                    }
                    
                }
            }
        }
            else
            {
                self.showErrorSnakbar(msg: favouriteViewModel.error?.localizedDescription  ?? "")
                print(favouriteViewModel.error ?? "")
            }
       /* favouriteViewModel.bindingData = {result , error in
            
            guard let error = error else {
                DispatchQueue.main.async { [self] in
                    deletedLeagueItem = leagueItem
                    savedLeagueArray.remove(at: indexPath.row)
                    self.savedLeagueTable.deleteRows(at: [indexPath], with: .automatic)
                   // savedLeagueTable.reloadData()
                    let successMsg = "\(String(describing: deletedLeagueItem?.league_name!)) was unsaved successfully"
                    showSuccessSnakbar(msg: successMsg , index: indexPath.row)
                }
                return
            }
            self.showErrorSnakbar(msg: error.localizedDescription)
            print(error.localizedDescription)
        }*/
    }
    private func showSuccessSnakbar(msg : String, index: Int ){
        let snackbar = TTGSnackbar(
            message: msg,
            duration: .long,
            actionText: "Undo",
            actionBlock: { (snackbar) in
                print("snack bar Click action!")
                self.flag = false
                if self.flag == false{
                    self.undoDeleting(index: index)
                }
               
            }
        )
        snackbar.actionTextColor = UIColor.blue
        snackbar.borderColor = UIColor.black
        snackbar.messageTextColor = UIColor.white
        snackbar.show()
    }
    private func undoDeleting(index: Int){
        if let league = deletedLeagueItem {
            savedLeagueArray.insert(league, at: index)
            savedLeagueTable.reloadData()
        }
    }
    private func showErrorSnakbar(msg: String)
    {
        let snackbar = TTGSnackbar(
            message: msg,
            duration: .middle
            )
        snackbar.borderColor = UIColor.black
        snackbar.messageTextColor = UIColor.white
        snackbar.show()
    }
}

extension FavouriteLeaguesViewController: CustomViewDelegate{
    func navigateToNextScene() {
        performSegue(withIdentifier: "secondStoryboard", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "secondStoryboard") {
            let vc = segue.destination as! LeagueDetailsVC
            
          //  vc.urlHelper = self.urlHelper
            print (urlHelper)
            
        }
    }
    private func showErrorAlert(){
        let alert : UIAlertController = UIAlertController(title:"Warning" , message: "No network connection!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "try again", style: .default , handler: { action in
            self.validateNavigation()
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: { action in
        }))
        
        self.present(alert, animated: true , completion: nil )
    }
    
    
    func validateNavigation(){
        if Reachability.forInternetConnection().isReachable()
            {
                self.navigateToNextScene()
            }
            else{
                showErrorAlert()
            }
        }
}
