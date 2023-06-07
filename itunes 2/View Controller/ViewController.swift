//
//  ViewController.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

// MVC -> Model, View controller
// View controller -> UI, logic

// MVVM -> Model, View (UI), View model (Logic) (100% testable)
// Direct creation of objects (X)

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewControllerViewModel

    init(viewModel: ViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}
extension ViewController: SecondViewControllerDelegate {
    func markFav(data: ResultsData) {
        viewModel.markFav(data: data)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = viewModel.searchBarEndButtonTapped(searchtext: searchBar.text)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITableViewDelegate { }
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: iTunesTableViewCell.identifier) as? iTunesTableViewCell else {
            return UITableViewCell()
        }
        cell.data = viewModel.getRowData(rowNumber: indexPath.row)
        return cell
    }
}

