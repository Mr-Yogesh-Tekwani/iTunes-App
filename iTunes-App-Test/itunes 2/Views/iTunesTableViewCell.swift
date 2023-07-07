//
//  iTunesTableViewCell.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

import UIKit

protocol iTunesTableViewCellDelegate {
    func favButtonTapped(data: ResultsData)
}

class iTunesTableViewCell: UITableViewCell {

 static let identifier = "iTunesTableViewCell"
    var networkClient = NetworkClient()
    
    var data: ResultsData? {
        didSet{
            setValue()
        }
    }
    var delegate: iTunesTableViewCellDelegate?
    let cellImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let cellAuthor: UILabel = {
        let author = UILabel()
        return author
    }()
    let kindLabel: UILabel = {
        let kLabel = UILabel()
        return kLabel
    }()
    
    let cellButton: UIButton = {
        let button = UIButton()
        button.setTitle("Fav", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(cellTapped), for: .touchUpInside)
       // button.isUserInteractionEnabled = true
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .white
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = .white
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    @objc func cellTapped(){
        guard let data = data else {
            return
        }
        delegate?.favButtonTapped(data: data)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.addArrangedSubview(cellImage)
        
        verticalStackView.addArrangedSubview(cellAuthor)
        verticalStackView.addArrangedSubview(kindLabel)
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(cellButton)
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [stackView.topAnchor.constraint(equalTo: self.topAnchor),
             stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
             stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
             cellImage.heightAnchor.constraint(equalToConstant: 120)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    func setValue() {
        guard let data = data else {
            return
        }
        self.cellAuthor.text = data.trackName
        
        self.kindLabel.text = data.kind
        
        networkClient.requestImage(urls: data.artworkUrl30) { image in
            DispatchQueue.main.async {
                self.cellImage.image = image
            }
                    
        }
    }
    
}
