//
//  AreaSelectViewController.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/04/25.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import UIKit

final class AreaSelectViewController: UITableViewController {
    @IBOutlet private var errorView: UIView!
    @IBOutlet weak private var errorTextView: UITextView!
    private let apiOperater: APIType = APIOperater()
    private var areas: [Area] = []
    private var selectedArea: Area?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArea()
        self.tableView.backgroundView = errorView
    }
    
    private func getArea() {
        apiOperater.getArea(success: { [weak self] areaResponseBody in
            self?.showArea(areaResponseBody)
            }, failure: { [weak self] error in
                self?.showError(error)
        })
    }
    
    private func showArea(_ areaResponseBody: AreaResponseBody) {
        self.areas = areaResponseBody.area
        self.tableView.reloadData()
    }
    
    private func showError(_ error: Error) {
        self.errorTextView.text = error.localizedDescription
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AreaCell", for: indexPath)
        let area = areas[indexPath.row]
        cell.textLabel?.text = area.areaName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    //セル選択時にエリア名をareaNameに代入
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedArea = areas[indexPath.row]
        
        let vc = PrefectureSelectViewController.instantiate(area: areas[indexPath.row])
        show(vc, sender: nil)
    }
}
