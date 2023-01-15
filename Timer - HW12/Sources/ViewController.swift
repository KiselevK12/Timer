//
//  ViewController.swift
//  Timer - HW12
//
//  Created by Константин Киселёв on 13.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    var timer = Timer()
    var isTimerStarted = false
    var isWorkTime = true
    var durationTime = 25
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:25"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пуск", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.backgroundColor = .systemGreen
        button.clipsToBounds = false
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "play"), for: .normal)
        
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
        button.setImage(UIImage(systemName: "stop"), for: .normal)
        
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
            make.right.equalTo(view).offset(-44)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(70)
            make.height.equalTo(45)
            make.centerX.equalTo(view).offset(-80)
            make.left.equalTo(view).offset(44)
        }
    }
        // MARK: - Action
        
    @objc private func startButtonTapped(_ sender: Any) {
        resetButton.isEnabled = true
        resetButton.alpha = 1.0
        if isWorkTime {
            timeLabel.textColor = .orange
        } else {
            timeLabel.textColor = .green
        }
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Пауза", for: .normal)
            startButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            startButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Продолжить", for: .normal)
            startButton.setImage(UIImage(systemName: "play"), for: .normal)
            startButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @objc private func resetButtonTapped(_ sender: Any) {
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        timer.invalidate()
        durationTime = 25
        isTimerStarted = false
        isWorkTime = true
        timeLabel.text = "00:25"
        startButton.setTitle("Пуск", for: .normal)
        startButton.setImage(UIImage(systemName: "play"), for: .normal)
        startButton.setTitleColor(UIColor.black, for: .normal)
        timeLabel.textColor = .orange
        }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    private func switchColorTimeLabel() {
        if isWorkTime {
            timeLabel.textColor = .orange
        } else {
            timeLabel.textColor = .green
        }
    }
    
    @objc private func updateTimer() {
        switchColorTimeLabel()
        if isWorkTime {
            durationTime -= 1
            timeLabel.text = formatTime()
        } else {
            durationTime -= 1
            timeLabel.text = formatTime()
            if durationTime == 0 {
                durationTime = 25
                isWorkTime = true
            }
        }
        if durationTime == 0 {
            durationTime = 6
            isWorkTime = false
        }
    }
    
    private func formatTime() -> String {
        let minutes = Int(durationTime) / 60 % 60
        let seconds = Int(durationTime) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
        
}
