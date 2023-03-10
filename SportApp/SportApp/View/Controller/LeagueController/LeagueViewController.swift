//
//  LeagueViewController.swift
//  SportApp
//
//  Created by ahmed on 02/02/2023.
//

import UIKit
import Reachability
class LeagueViewController: UIViewController{
    
    @IBOutlet weak var leagueTable: UITableView!
    var leagueArray = [League]()
    let allLeaguesViewodel = AllLeaguesViewodel()
    var leaguesPerPages = 10
    var limit = 10
    var paginationLeagues: [League] = []
    var indicator: UIActivityIndicatorView?
    var urlHelper: URLHelper = URLHelper(endPoint: "" , leagueId: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableConfiguration()
        handleDataFetching()
        print(urlHelper)
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        if let ind = indicator{
           self.view.addSubview(ind)
        }
    }
    
    func tableConfiguration(){
        leagueTable.delegate = self
        leagueTable.dataSource = self
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        leagueTable.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension LeagueViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Leagues"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LeagueTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.cellTitle.text = paginationLeagues[indexPath.row].league_name
        //cell.cellImage.image = UIImage(named: "sport")
        if let stringUrl = paginationLeagues[indexPath.row].league_logo {
          /*  DispatchQueue.global().async {
                cell.cellImage.load(urlString: stringUrl)
            }*/
            let url = URL(string: stringUrl)
            cell.cellImage?.kf.setImage(with: url)
        }
        else {
            cell.cellImage.image = UIImage(named: "sport")
        }
            
        return cell
    }
/*func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }*/
    
}

extension LeagueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        urlHelper.leagueId = leagueArray[indexPath.row].league_key
        navigateToNextScene()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == leagueTable
        {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)
            {
                getMoreData()
                
            }
        }
    }
}

extension LeagueViewController {
    func checkNetworkAvilability() -> Bool{
        if Reachability.forInternetConnection().isReachable(){
            return true }
        else {
            return false
        }
    }
    
    func getLeagues(){
        let endpoint = urlHelper.endPoint ?? ""
        allLeaguesViewodel.fetchData(endPoint: endpoint )
        allLeaguesViewodel.bindingData = { leaguesResult, error in
            if let leagues = leaguesResult {
                self.leagueArray = leagues.result ?? []
                self.limit = self.leagueArray.count
                
                for i in 0..<10 {
                    self.paginationLeagues.append(self.leagueArray[i])
                }
                DispatchQueue.main.async {
                    if let ind = self.indicator{
                       // ind.center = self.leagueTable.anchorPoint
                           ind.stopAnimating()
                       }
                    self.leagueTable.reloadData()
                }
            }
              if let error = error {
                  if let ind = self.indicator{
                         ind.stopAnimating()
                     }
                  print(error.localizedDescription)
              }
          }
    }
}

extension LeagueViewController: CustomViewDelegate
{
    func navigateToNextScene() {
        performSegue(withIdentifier: "webView", sender: self)

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "webView") {
            let vc = segue.destination as! LeagueDetailsVC
           
                vc.urlHelper = self.urlHelper
                print (urlHelper)
            
        }
    }
    
    func showErrorAlert(){
        let alert : UIAlertController = UIAlertController(title:"Add" , message: "No network connection !", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "try again", style: .default , handler: { action in
            self.handleDataFetching()
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel , handler: { action in
        }))
        
        self.present(alert, animated: true , completion: nil )
    }
    private func handleDataFetching(){
        if checkNetworkAvilability() {
            getLeagues()
        }
        else
        {
            showErrorAlert()
        }
    }
}

// MARK: - pagination
extension LeagueViewController
{
    private func displayMoreData(row: Int)
    {
        if row == paginationLeagues.count - 1
        {
            getMoreData()
        }
    }
    private func getMoreData() {
            if leaguesPerPages >= limit {
                return
            }
            else if leaguesPerPages >= limit - 10 {
                for i in leaguesPerPages..<limit {
                    paginationLeagues.append(leagueArray[i])
                }
                self.leaguesPerPages += 10
            }
            else {
                for i in leaguesPerPages..<leaguesPerPages + 10 {
                    paginationLeagues.append(leagueArray[i])
                }
                self.leaguesPerPages += 10
           }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.leagueTable.reloadData()
            }
        }
}
