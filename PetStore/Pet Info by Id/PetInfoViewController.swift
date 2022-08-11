//
//  PetInfoViewController.swift
//  PetStore
//
//  Created by Nodir on 11/08/22.
//

import UIKit

protocol PetInfoView {
    func didUpdateData(_ model: Codable)
    func didFailWithError(error: Error)
}

class PetInfoViewController: UIViewController {
    
    // MARK: - Properties
    var id: Int?
    var present: PetInfo!
    weak var petModel: PetModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        present.viewDidLoad()
        setupUI()
    }
    
    lazy var dogName: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.lineBreakMode = .byCharWrapping
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6462910633)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private func setupUI() {

        self.view.backgroundColor = .white
        
        self.view.addSubview(dogName)
        
        navigationItem.title = "League"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        NSLayoutConstraint.activate([
            dogName.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            dogName.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PetInfoViewController: ViewUpdate {
    func didUpdateData(_ model: Codable) {
        self.petModel = model as? PetModel
        self.dogName.text = petModel?.name
    }
    
    func didFailWithError(error: Error) {
        print("Failed with error: ", error)
    }
    
    func onRetrieveData(_ model: AnyObject?) {
        let arrPetMod = model as? [PetModel]
        guard let index = arrPetMod?.firstIndex(where: { mod in
            mod.id == id
        }) else {
            return
        }
        self.petModel = arrPetMod?[index]
        self.dogName.text = petModel?.name
        
    }
    
    func onSaveDate() -> AnyObject {
        return self.petModel as AnyObject
    }
    
}
