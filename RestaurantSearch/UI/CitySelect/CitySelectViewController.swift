//
//  CitySelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/04/10.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import UIKit

final class CitySelectViewController: UITableViewController {
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorMessageLabel: UILabel!
    var apiOperater: APIType = APIOperater()
    private var cityList: [City] = []
    private var prefecture: Prefecture!
    
    static func instantiate(prefecture: Prefecture) -> CitySelectViewController {
        let vc = UIStoryboard(name: "CitySelect", bundle: nil).instantiateInitialViewController() as! CitySelectViewController
        vc.prefecture = prefecture
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = prefecture.prefName
        
        getCity()
    }
    
    private func getCity() {
        apiOperater.getCity(
            success: { [weak self] cityResponseBody in
                self?.showCity(cityResponseBody)
            },
            failure: { [weak self] error in
                self?.showError(error)
            }
        )
    }
    
    private func showCity(_ cityResponseBody: CityResponseBody) {
        cityList = cityResponseBody.cityList.filter { $0.pref.prefName == prefecture.prefName }
        tableView.backgroundView = nil
        tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        errorMessageLabel.text = error.localizedDescription
        tableView.backgroundView = errorView
    }
    
    private func showTownSelect(_ city: City) {
        let vc = TownSelectViewController.instantiate(city: city)
        show(vc, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        cell.textLabel?.text = cityList[indexPath.row].cityName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityList[indexPath.row]
        showTownSelect(city)
    }
}
