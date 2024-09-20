//
//  CourntryTableView.swift
//  NaverSens
//
//  Created by 박제형 on 9/13/24.
//

import Foundation
import UIKit

class CourntryTableView: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchCountry: UITextField!
    @IBOutlet weak var countryTableView: UITableView!
    
    var countries: [List] = []
    var filteredCountries: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        searchBarUI()
    }
    
    func initUI() {
        countryTableView.delegate = self
        countryTableView.dataSource = self
        
        setTable()
    }
    
    func setTable() {
        guard
            let jsonData = load(),
            let countryData = try? JSONDecoder().decode(CountryList.self, from: jsonData)
        else { return }
        
        countries = countryData.list
        filteredCountries = countries
        countryTableView.reloadData()
    }
    
    func load() -> Data? {
        let fileNm: String = "Country"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            return nil
        }
    }
    
    func searchBarUI() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal
    }
    
}

extension CourntryTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        
        let country = filteredCountries[indexPath.row]
        cell.countryName.text = country.country
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
}

extension CourntryTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCountry = filteredCountries[indexPath.row]
        
        let preVC = self.presentingViewController
        
        guard let VC = preVC as? ViewController else { return }
        VC.paramName = selectedCountry.country
        VC.paramCode = selectedCountry.code
        
        self.presentingViewController?.dismiss(animated: true)
    }
}

extension CourntryTableView: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
        
        // self.reload()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.country.lowercased().contains(searchText.lowercased())}
        }
        
        self.reload()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.text = ""
        filteredCountries = countries
        self.reload()
        self.searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
        
        
        
        
    }
    
    func reload() {
        self.countryTableView.reloadData()
    }
    
}
