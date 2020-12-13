//
//  PopUpViewController.swift
//  Task
//
//  Created by Basma on 12/12/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    private var hotspotsButton = UIButton()
    private var eventsButton = UIButton()
    private var attractionsButton = UIButton()
    private var mapButton = UIButton()
    private let originalRect = CGRect(x: 176, y: 805, width: 62, height: 62)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hotspotsButton = createButton(buttonName: "hotspot_icon")
        eventsButton = createButton(buttonName: "events_icon")
        attractionsButton = createButton(buttonName: "attarctions_icon")
        mapButton = createButton(buttonName: "small_grey_location_pin")
        
        createBellmanButton()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateOutButtons()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        animateInButtons()
    }
    
    func createBellmanButton(){
        let button = UIButton(frame: originalRect)
        button.setImage(UIImage(named: "bellman_bottom-icon"), for: .normal)
        button.addTarget(self, action: #selector(bellmanButtonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func createButton(buttonName : String)-> UIButton{
        let button = UIButton(frame: originalRect)
        button.backgroundColor = .white
        button.setImage(UIImage(named: buttonName), for: .normal)
        self.view.addSubview(button)
        roundCornersForView(view: button)
        addShadowToView(view : button)
        
        return button
    }
    
    func animateButton(button : UIButton, duration : TimeInterval, damping : CGFloat, rect : CGRect){
        UIView.animate(withDuration: duration, delay: 0.0,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: 0.0,
                       options: [], animations: {
                        button.frame = rect
        })
    }
    
    func animateOutButtons(){
        let damping : CGFloat = 0.6
        animateButton(button : hotspotsButton, duration : 0.3, damping: damping, rect : CGRect(x: 90, y: 811, width: 62, height: 62))
        animateButton(button : eventsButton, duration : 0.5, damping: damping, rect : CGRect(x: 120, y: 725, width: 62, height: 62))
        animateButton(button : attractionsButton, duration : 0.8, damping: damping, rect : CGRect(x: 234, y: 725, width: 62, height: 62))
        animateButton(button : mapButton, duration : 1.0, damping: damping, rect : CGRect(x: 260, y: 811, width: 62, height: 62))
    }
    func animateInButtons(){
        let damping : CGFloat = 1.0
        animateButton(button : mapButton, duration : 0.3, damping: damping, rect : originalRect)
        animateButton(button : attractionsButton, duration : 0.5, damping: damping, rect : originalRect)
        animateButton(button : eventsButton, duration : 0.8, damping: damping, rect : originalRect)
        animateButton(button : hotspotsButton, duration : 1.0, damping: damping, rect : originalRect)
    }
    
    @objc func bellmanButtonAction(sender: UIButton!) {
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(dismissViewController), userInfo: nil, repeats: true)
        animateInButtons()
    }
    @objc func dismissViewController() {
        self.dismiss(animated: false, completion: nil)
    }
    func roundCornersForView(view : UIView){
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
    }
    
    func addShadowToView(view : UIView){
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 4.0
        view.layer.masksToBounds = false
    }
}
