//
//  ViewController.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

import UIKit

class ViewController: UIViewController {

    var favData: [ResultsData] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let searchBar = UISearchBar()
    var tableView: UITableView = {
        let tv = UITableView()
      //  tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
        self.view.addSubview(stackView)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(iTunesTableViewCell.self, forCellReuseIdentifier: iTunesTableViewCell.identifier)
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
    }
}
extension ViewController: SecondViewControllerDelegate {
    func markFav(data: ResultsData) {
        favData.append(data)
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text  , text != "" else{
            return
        }
        let svc = SecondViewController()
        svc.delegate = self
    svc.searchTerm = text
        self.navigationController?.pushViewController(svc, animated: true)
    }
}
extension ViewController: UITableViewDelegate{
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: iTunesTableViewCell.identifier) as? iTunesTableViewCell else {
            return UITableViewCell()
        }
        print(favData[indexPath.row])
        cell.data = favData[indexPath.row]
        return cell
    }
    
}

