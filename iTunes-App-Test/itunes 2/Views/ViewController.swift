//
//  ViewController.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

import UIKit

class ViewController: UIViewController {

    var viewModel : ViewControllerViewModel?
    
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
        tv.backgroundColor = .white
      //  tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .white
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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
        guard let dest = SecondVcViewModel().makeVc() as? SecondViewController else {
            return
        }
        dest.delegate = self
        dest.searchTerm = text
        self.navigationController?.pushViewController(dest, animated: true)
    }
}
extension ViewController: UITableViewDelegate{
    
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: iTunesTableViewCell.identifier) as? iTunesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.data = favData[indexPath.row]
        return cell
    }
    
}

