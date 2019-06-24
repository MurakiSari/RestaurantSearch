//
//  SearchTopViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/04/22.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

final class SearchTopViewController: UITableViewController, UITextFieldDelegate, TownSelectViewControllerDelegate {
    @IBOutlet weak private var freewordSearchBar: UITextField!
    @IBOutlet weak private var areaLabel: UILabel!
    @IBOutlet weak private var genreLabel: UILabel!
    @IBOutlet weak private var sceneLabel: UILabel!
    private var selectedTown: Town?
    let freewordDatabase = FreewordDatabase.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFreeword()
    }
    
    private func updateFreeword() {
        freewordSearchBar.text = freewordDatabase.get()
    }
    
    private func showAreaSelect() {
        let vc = AreaSelectViewController.instantiate()
        show(vc, sender: nil)
    }
    
    private func showShopList() {
        let vc = ShopListViewController.instantiate(townCode: selectedTown?.townCode ?? "", freeword: freewordSearchBar.text ?? "")
        show(vc, sender: nil)
    }
    
    private func showValidationAlert() {
        let alertController = UIAlertController(title: "Error", message: "検索条件を入力してください", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    private func validateInput() -> Bool {
        return selectedTown?.townCode == nil && freewordSearchBar.text == ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            showAreaSelect()
            freewordDatabase.set(freewordSearchBar.text)
        case 4:
            if validateInput() {
                showValidationAlert()
            } else {
                showShopList()
            }
        default:
            return
        }
    }
    
    // MARK: - Actions

    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        freewordSearchBar.resignFirstResponder()
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        freewordSearchBar.resignFirstResponder()
        return true
    }
    
    // MARK: - TownSelectViewControllerDelegate

    func townSelected(_ town: Town) {
        navigationController?.popToRootViewController(animated: true)
        areaLabel.text = town.townName
        selectedTown = town
    }
}
