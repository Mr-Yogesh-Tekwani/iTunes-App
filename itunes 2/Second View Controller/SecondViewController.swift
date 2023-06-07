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

    var secondViewModel : SecondViewControllerViewModel?
    
    init(secondViewModel: SecondViewControllerViewModel? = nil) {
        self.secondViewModel = secondViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
   // var data2 = ["A","B","C"]
   // let searchBar = UISearchBar()

    
    var delegate: SecondViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
     //   searchBar.delegate = self
        
       // view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.delegate =  self
        tableView.dataSource = self
       tableView.register(iTunesTableViewCell.self, forCellReuseIdentifier: iTunesTableViewCell.identifier)
        
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
             tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        (secondViewModel?.getHeadingCount())!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        secondViewModel?.getHeadingData(section: section)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (secondViewModel?.getRowCount(section: section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: iTunesTableViewCell.identifier) as? iTunesTableViewCell else {
            return UITableViewCell()
        }
    
        cell.data = secondViewModel?.getRowData(rownumber: indexPath.row, section: indexPath.section)
        cell.delegate = self
        return cell
    }
}
extension SecondViewController: iTunesTableViewCellDelegate {
    func favButtonTapped(data: ResultsData) {
        delegate?.markFav(data: data)
    }
}
