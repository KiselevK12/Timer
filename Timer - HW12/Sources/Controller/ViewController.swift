//
//  ViewController.swift
//  Timer - HW12
//
//  Created by Константин Киселёв on 13.01.2023.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    // MARK: - Timer properties
    
    var timer = Timer()
    var isTimerStarted = false
    var isWorkTime = true
    var durationTime = 250
    var isAnimationStarted = false
    
    // MARK: - Progress Bar
    
    let frontProgressLayer = CAShapeLayer()
    let backProgressLayer = CAShapeLayer()
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // MARK: - UI Elements
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:25"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 55, weight: .bold)
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
        button.backgroundColor = .systemCyan
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
        view.backgroundColor = UIColor(red: 0.7, green: 0.8, blue: 1, alpha: 1)
        drawBackLayer()
    }
    
    private func setupHierarchy() {
        [timeLabel,
        startButton,
        resetButton].forEach(view.addSubview)
    }
    
    private func setupLayout() {
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(120)
            make.height.equalTo(45)
            make.centerX.equalTo(view).offset(80)
            make.right.equalTo(view).offset(-44)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(120)
            make.height.equalTo(45)
            make.centerX.equalTo(view).offset(-80)
            make.left.equalTo(view).offset(44)
        }
    }
        // MARK: - Action
        
    @objc private func startButtonTapped(_ sender: Any) {
        resetButton.isEnabled = true
        resetButton.alpha = 1.0
        if !isTimerStarted {
            drawFrontLayer()
            startResumeAnimation()
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Пауза", for: .normal)
            startButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            startButton.setTitleColor(UIColor.black, for: .normal)
        } else {
            pauseAnimation()
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Продолжить", for: .normal)
            startButton.setImage(UIImage(systemName: "play"), for: .normal)
            startButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    @objc private func resetButtonTapped(_ sender: Any) {
        stopAnimation()
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        timer.invalidate()
        durationTime = 250
        isTimerStarted = false
        isWorkTime = true
        timeLabel.text = "00:25"
        startButton.setTitle("Пуск", for: .normal)
        startButton.setImage(UIImage(systemName: "play"), for: .normal)
        startButton.setTitleColor(UIColor.black, for: .normal)
        timeLabel.textColor = .orange
        }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    private func switchColorTimeLabel() {
        if isWorkTime {
            timeLabel.textColor = .orange
        } else {
            timeLabel.textColor = .systemGreen
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
                durationTime = 250
                isWorkTime = true
            }
        }
        if durationTime == 0 {
            durationTime = 60
            isWorkTime = false
        }
    }
    
    private func formatTime() -> String {
        let minutes = Int(durationTime) / 600 % 60
        let seconds = Int(durationTime) / 10 % 60
        let splitSecond = Int(durationTime) % 10
        return String(format: "%02i:%02i", seconds, splitSecond)
    }
    
    func drawBackLayer() {
        backProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        backProgressLayer.strokeColor = UIColor.white.cgColor
        backProgressLayer.fillColor = UIColor.clear.cgColor
        backProgressLayer.lineWidth = 15
        view.layer.addSublayer(backProgressLayer)
    }
    
    func drawFrontLayer() {
        frontProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY), radius: 100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        frontProgressLayer.strokeColor = UIColor.systemGreen.cgColor
        frontProgressLayer.fillColor = UIColor.clear.cgColor
        frontProgressLayer.lineWidth = 15
        view.layer.addSublayer(frontProgressLayer)
    }
    
    func startResumeAnimation() {
        if !isAnimationStarted {
            startAnimation()
        } else {
            resumeAnimation()
        }
    }
    
    func startAnimation() {
        resetAnimation()
        frontProgressLayer.strokeEnd = 0.0
        animation.keyPath = "strokeEnd"
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = CFTimeInterval(Double(durationTime / 10))
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        frontProgressLayer.add(animation, forKey: "strokeEnd")
        isAnimationStarted = true
    }
    
    func resetAnimation() {
        frontProgressLayer.speed = 1.0
        frontProgressLayer.timeOffset = 0.0
        frontProgressLayer.beginTime = 0.0
        frontProgressLayer.strokeEnd = 0.0
        isAnimationStarted = false
    }
    
    func pauseAnimation() {
        let pausedTime = frontProgressLayer.convertTime(CACurrentMediaTime(),
                                                             from: nil)
        frontProgressLayer.speed = 0.0
        frontProgressLayer.timeOffset = pausedTime
    }
    
    func resumeAnimation() {
        let pausedTime = frontProgressLayer.timeOffset
        frontProgressLayer.speed = 1.0
        frontProgressLayer.timeOffset = 0.0
        frontProgressLayer.beginTime = 0.0
        let timeSincePaused = frontProgressLayer.convertTime(CACurrentMediaTime(),
                                                             from: nil) - pausedTime
        frontProgressLayer.beginTime = timeSincePaused
    }
    
    func stopAnimation() {
        frontProgressLayer.speed = 1.0
        frontProgressLayer.timeOffset = 0.0
        frontProgressLayer.beginTime = 0.0
        frontProgressLayer.strokeEnd = 0.0
        frontProgressLayer.removeAllAnimations()
        isAnimationStarted = false
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stopAnimation()
        if isTimerStarted {
            startResumeAnimation()
        }
    }
}
