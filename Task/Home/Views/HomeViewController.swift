//
//  ViewController.swift
//  Task
//
//  Created by Basma on 12/12/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel = HomeViewModel ()

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bellmanButton: UIButton!
    @IBAction func bellmanButtonAction(_ sender: Any) {
        let popUpViewController = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
        popUpViewController.modalPresentationStyle = .overFullScreen
        present(popUpViewController, animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initViewModel(){
        viewModel.updateLoadingStatus = {[weak self] () in
            DispatchQueue.main.async {
                switch self?.viewModel.state {
                case .error:
                    self?.indicator.stopAnimating()
                    self?.tableView.alpha = 0.0
                case .loading:
                    self?.indicator.startAnimating()
                    self?.indicator.alpha = 1.0
                    self?.tableView.alpha = 0.0
                case .loaded:
                    self?.indicator.stopAnimating()
                    self?.tableView.alpha = 1.0
                case .empty:
                    self?.indicator.stopAnimating()
                    self?.tableView.alpha = 0.0
                    self?.indicator.alpha = 0.0

                case .none: break

                }
            }
        }
            viewModel.reloadTableViewClosure = { [weak self] () in
                DispatchQueue.main.async {
                    self?.tableView.delegate = self
                    self?.tableView.dataSource = self
                    self?.tableView.reloadData()
                }
            }
            viewModel.getData()
    }

    func initView() {
        searchView.layer.cornerRadius = 10
        searchView.clipsToBounds = true
        tableView.register(MainHomeCell.self, forCellReuseIdentifier: "MainHomeCell")
        tableView.register(UINib(nibName: "MainHomeCell", bundle: nil), forCellReuseIdentifier: "MainHomeCell")
        tableView.separatorStyle = .none
    }
    

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 370
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainHomeCell") as! MainHomeCell
        if indexPath.row == 0 {
            cell.titleLabel.text = "Hotspots"
            cell.cellsViewModels = viewModel.getHotspotCellViewModel()
            cell.titleImageView.image = UIImage(named: "hotspot_icon")
        }else if indexPath.row == 1 {
            cell.titleLabel.text = "Events"
            cell.titleImageView.image = UIImage(named: "events_icon")
            cell.cellsViewModels = viewModel.getEventsCellViewModel()
        }else {
            cell.titleLabel.text = "Attractions"
            cell.titleImageView.image = UIImage(named: "attarctions_icon")
            cell.cellsViewModels = viewModel.getAttractionsCellViewModel()
        }
        flipButton(button: cell.viewAllButton)
        return cell
    }
    func flipButton (button : UIButton){
        button.semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
    }
    
}
