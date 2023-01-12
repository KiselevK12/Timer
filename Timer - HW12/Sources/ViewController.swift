//
//  ViewController.swift
//  Timer - HW12
//
//  Created by Константин Киселёв on 13.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var countingLabel: UILabel = {
        let label = UILabel()
        label.text = "25:00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .systemCyan
    }
    
    private func setupHierarchy() {
        [countingLabel].forEach(view.addSubview)
    }
    
    private func setupLayout() {
        
        countingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(-100)
            make.centerX.equalTo(view)
        }
    }
        // MARK: - Action
        
        private func buttonPressed() {
            
        }
        
}

