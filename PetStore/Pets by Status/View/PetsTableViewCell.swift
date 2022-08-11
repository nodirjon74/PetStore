//
//  PestsTableViewCell.swift
//  PetStore
//
//  Created by Nodir on 09/08/22.
//

import UIKit

class PetsTableViewCell: UITableViewCell {
    
    lazy var petName: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var petStatus: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var petInfoStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(petInfoStack)
        
        petInfoStack.addArrangedSubview(petName)
        petInfoStack.addArrangedSubview(petStatus)
        
        NSLayoutConstraint.activate([
            petInfoStack.topAnchor
                .constraint(equalTo: self.contentView.topAnchor, constant: 7),
            petInfoStack.leadingAnchor
                .constraint(equalTo: self.contentView.leadingAnchor, constant: 7),
            petInfoStack.trailingAnchor
                .constraint(equalTo: self.contentView.trailingAnchor, constant: -7),
            petInfoStack.bottomAnchor
                .constraint(equalTo: self.contentView.bottomAnchor, constant: -7)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
