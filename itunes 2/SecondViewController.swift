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

    var searchTerm: String?
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var data: ResultsModel? {
        didSet{
            var kindData: [String:[ResultsData]] = [:]
            for value in data?.results ?? [] {
                if let kind = value.kind {
                    if kindData[kind] != nil {
                        kindData[kind]?.append(value)
                    }else{
                        kindData[kind] = [value]
                    }
                }
            }
         
            kindDict = kindData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   // var data2 = ["A","B","C"]
   // let searchBar = UISearchBar()

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
            requestData(searchTerm: searchTerm, completionHandler: { artistData in
                self.data = artistData
              
            } )
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
        kindDict.keys.count ?? 0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        kindDict.keys.sorted()[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(data?.results.count)
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
