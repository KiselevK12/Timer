//
//  ViewController.swift
//  Timer - HW12
//
//  Created by Константин Киселёв on 13.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "25:00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 25
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пуск", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .systemGreen
        button.clipsToBounds = false
        button.layer.cornerRadius = 20
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сброс", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemGray
        button.clipsToBounds = false
        button.layer.cornerRadius = 20
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
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
        [timeLabel,
        startButton,
        resetButton].forEach(view.addSubview)
    }
    
    private func setupLayout() {
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(-100)
            make.centerX.equalTo(view)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(70)
            make.height.equalTo(45)
            make.centerX.equalTo(view).offset(80)
            make.right.equalTo(view).offset(-50)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(70)
            make.height.equalTo(45)
            make.centerX.equalTo(view).offset(-80)
            make.left.equalTo(view).offset(50)
        }
    }
        // MARK: - Action
        
    @objc private func startButtonTapped(_ sender: Any) {
        resetButton.isEnabled = true
        resetButton.alpha = 1.0
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Пауза", for: .normal)
            startButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Продолжить", for: .normal)
            startButton.setTitleColor(UIColor.blue, for: .normal)
        }
    }
    
    @objc private func resetButtonTapped(_ sender: Any) {
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        timer.invalidate()
        time = 25
        isTimerStarted = false
        timeLabel.text = "25:00"
        startButton.setTitle("Пуск", for: .normal)
        startButton.setTitleColor(UIColor.black, for: .normal)
        }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        time -= 1
        timeLabel.text = formatTime()
    }
    
    private func formatTime() -> String {
        let seconds = Int(time) % 60
        let splitSecond = 0
        return String(format: "%02i:%02i", seconds, splitSecond)
    }
        
}

