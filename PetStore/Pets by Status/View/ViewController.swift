//
//  ViewController.swift
//  PetStore
//
//  Created by Nodir on 08/08/22.
//

import UIKit

protocol ViewUpdate {
    func onRetrieveData(_ model: AnyObject?)
    func onSaveDate() -> AnyObject
    func didUpdateData(_ model: Codable)
    func didFailWithError(error: Error)
}

class ViewController: UIViewController {
    
    //MARK: - Properties
    var petModel: [PetModel] = []
    var present: PetPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        present.viewDidLoad()
        segContrl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        setupUI()

        
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PetsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var segContrl: UISegmentedControl = {
        var seg = UISegmentedControl(items: ["Available", "Sold", "Pending"])
        seg.selectedSegmentIndex = (petModel.isEmpty ? 0 : present.segmentIndex(petModel[0].status))!
        seg.translatesAutoresizingMaskIntoConstraints = false
        return seg
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .darkGray
        label.text = "No data"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            present.status = "available"
            break
        case 1:
            present.status = "sold"
            break
        case 2:
            present.status = "pending"
            break
        default:
            present.status = "available"
            break
        }
        present.viewDidLoad()
    }
    
    //    MARK: - SETUP UI
        private func setupUI() {

            self.view.backgroundColor = .white
            
            self.view.addSubview(segContrl)
            self.view.addSubview(tableView)
            self.view.addSubview(placeholderLabel)
            
            
            navigationItem.title = "Pet Shop"
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            NSLayoutConstraint.activate([
                segContrl.centerXAnchor
                    .constraint(equalTo: self.view.centerXAnchor),
                segContrl.topAnchor
                    .constraint(equalTo: self.view.topAnchor, constant: 10),
                tableView.widthAnchor
                    .constraint(equalTo: self.view.widthAnchor),
                tableView.topAnchor
                    .constraint(equalTo: self.segContrl.bottomAnchor),
                tableView.bottomAnchor
                    .constraint(equalTo: self.view.bottomAnchor),
                placeholderLabel.centerXAnchor
                    .constraint(equalTo: self.view.centerXAnchor),
                placeholderLabel.centerYAnchor
                    .constraint(equalTo: self.view.centerYAnchor)
            ])
        }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = self.petModel.isEmpty
        
        if !petModel.isEmpty && segContrl.titleForSegment(at: segContrl.selectedSegmentIndex)! == petModel[0].status.capitalized {
            placeholderLabel.isHidden = true
            return petModel.count
        } else {
            placeholderLabel.isHidden = false
            return 0
        }
             
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PetsTableViewCell
        cell.petName.text = petModel[indexPath.row].name
        cell.petStatus.text = "Status: " + petModel[indexPath.row].status
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newViewController = PetInfoViewController()
        let present = PetInfoPresent(view: newViewController, find: (petModel[indexPath.row].id))
        newViewController.present = present
        newViewController.id = petModel[indexPath.row].id
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}


extension ViewController: ViewUpdate {
    func onRetrieveData(_ model: AnyObject?) {
        self.petModel = model as! [PetModel]
        tableView.reloadData()
    }
    
    func onSaveDate() -> AnyObject {
        return self.petModel as AnyObject
    }
    
    func didUpdateData(_ model: Codable) {
        self.petModel = (model as? [PetModel])!
        present.onSave()
        tableView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        print("Failed with error: ", error)
    }
}
