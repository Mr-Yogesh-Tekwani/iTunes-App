//
//  SecondViewController.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

import UIKit


protocol SecondViewControllerDelegate {
    func markFav(data: ResultsData)
}

class SecondViewController: UIViewController, UISearchBarDelegate {

    var networkClient = NetworkClient()
    var svcViewModel : SecondVcViewModel?
    var searchTerm: String?
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var data: ResultsModel? {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    var kindDict: [String:[ResultsData]] = [:]
    var delegate: SecondViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
     //   searchBar.delegate = self
        
       // view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.delegate =  self
        tableView.dataSource = self
       tableView.register(iTunesTableViewCell.self, forCellReuseIdentifier: iTunesTableViewCell.identifier)
        
        if let searchTerm = searchTerm {
            print(searchTerm)
            svcViewModel?.searchSong(searchTerm: searchTerm, completion: { alldata in
                self.data = alldata
            })
            
        }
        
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
    }
}
extension SecondViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SecondViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        kindDict.keys.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        kindDict.keys.sorted()[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = kindDict.keys.sorted()[section]
        return kindDict[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: iTunesTableViewCell.identifier) as? iTunesTableViewCell else {
            return UITableViewCell()
        }
        let key = kindDict.keys.sorted()[indexPath.section]
        let resultData = kindDict[key]
        cell.data = resultData?[indexPath.row]
        cell.delegate = self
        return cell
    }
}
extension SecondViewController: iTunesTableViewCellDelegate {
    func favButtonTapped(data: ResultsData) {
        delegate?.markFav(data: data)
    }
}
