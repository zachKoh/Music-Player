//
//  ChartViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 07/02/2024.
//

import UIKit
import SwiftUI
import SnapKit

class ChartViewController: UIViewController {
    
    var artists: [artist] = [
        artist(name: "Billy Joel", plays: 6),
        artist(name: "Daniel Ceasar", plays: 5),
        artist(name: "The Beatles", plays: 3),
        artist(name: "Donny Hathaway", plays: 1),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let controller = UIHostingController(rootView: SwiftUIChart(artists: artists))
        guard let chartView = controller.view else {
            return
        }
        
        view.addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(500)
        }
    }

}
