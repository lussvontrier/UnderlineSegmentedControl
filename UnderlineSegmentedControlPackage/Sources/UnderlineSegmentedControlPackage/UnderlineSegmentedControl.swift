//
//  UnderlineSegmentedControl.swift
//  HandySwift
//
//  Created by Lusine Magauzyan on 20.10.22.
//

import UIKit

public class UnderlineSegmentControl: UIControl {
    
    private var segments: [String]
    private var segmentButtons: [GradientButton] = []
    private var options: UnderlineSegmentedControlOptions
        
    ///Omitted by .valueChanged action the target is subscribed to. Changed when a new segment is tapped.
    private(set) public var selectedSegmentIndex: Int = 0
    
    private lazy var segmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var underlineSelector: UIView = {
        let view = UIView()
        view.backgroundColor = options.underlineColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public init(with segments: [String], options: UnderlineSegmentedControlOptions? = nil) {
        self.segments = segments
        if let options = options {
            self.options = options
        } else {
            self.options = UnderlineSegmentedControlOptions()
        }
        super.init(frame: .zero)
        configureSegmentButtons(with: segments)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupUI()
    }
    
    private func configureSegmentButtons(with segments: [String]) {
        self.segmentButtons.forEach({$0.removeFromSuperview()})
        self.segmentButtons.removeAll()
        
        for segmentTitle in segments {
            let segment = GradientButton()
            var configuration = GradientButton.Configuration.filled()
            configuration.contentInsets = options.segmentTitleInsets
            configuration.baseBackgroundColor = options.segmentBackgroundColor
            
            var container = AttributeContainer()
            container.font = options.segmentTitleFont
            container.foregroundColor = options.segmentTitleColor
            configuration.attributedTitle = AttributedString(segmentTitle, attributes: container)
            segment.configuration = configuration
            
            segment.setGradientLevelLocations(locations: [0.0, 0.0, 0.0, 0.0])
            segment.setGradientColors(colors: [options.segmentTitleColor,
                                               options.selectedSegmentTitleColor,
                                               options.selectedSegmentTitleColor,
                                               options.segmentTitleColor])

            segment.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            self.segmentButtons.append(segment)
        }
        segmentButtons[selectedSegmentIndex].setGradientLevelLocations(locations: [0.0, 0.0, 1.0, 1.0])
    }
    
    private func setupUI() {
        addSubview(segmentStackView)
        NSLayoutConstraint.activate([
            segmentStackView.leftAnchor.constraint(equalTo: leftAnchor),
            segmentStackView.topAnchor.constraint(equalTo: topAnchor),
            segmentStackView.rightAnchor.constraint(equalTo: rightAnchor),
            segmentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        segmentStackView.subviews.forEach({ $0.removeFromSuperview() })
        for view in segmentButtons {
            segmentStackView.addArrangedSubview(view)
        }
        
        ///Calling layoutIfNeeded so segment buttons' frame origin x is set before moving forward
        self.layoutIfNeeded()

        addSubview(underlineSelector)
        let selectorWidth = self.frame.width / CGFloat(self.segments.count)
        underlineSelector.frame = CGRect(x: segmentButtons[selectedSegmentIndex].frame.origin.x, y: self.frame.height - options.underlineHeight, width: selectorWidth, height: options.underlineHeight)
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        for (index, segment) in segmentButtons.enumerated() {
            if segment == sender && selectedSegmentIndex != index {
                self.selectedSegmentIndex = index
                sendActions(for: .valueChanged)
            }
        }
    }
    
    private func updateUnderline(with xPosition: CGFloat) {
        underlineSelector.frame.origin.x = xPosition / CGFloat(segments.count)
    }
        
    private func updateGradientLocations(with xPosition: CGFloat, frameWidth: CGFloat) {

        ///Adding 1 so we don't have to deal with negative numbers
        let ratio = 1 + (xPosition / frameWidth)
        let percent = ratio.truncatingRemainder(dividingBy: 1.0)
        let location = NSNumber(value: Float(percent))
        
        let rightIndex = Int(ratio)
        let leftIndex = Int(ratio-1)
        
        if leftIndex >= 0 {
            segmentButtons[leftIndex].setGradientLevelLocations(locations: [location, location, 1.0, 1.0])
        }
        if rightIndex < segmentButtons.count {
            segmentButtons[rightIndex].setGradientLevelLocations(locations: [0, 0, location, location])
        }
    }
    
    ///Call from connected scrollview's scrollViewDidScroll method to continuously update underline's x position and colors
    ///- parameter xPosition: scrollView.contentOffset.x
    ///- parameter frameWidth: self.frame.width
    public func updateSegmentSelectionInteractive(with xPosition: CGFloat, frameWidth: CGFloat) {
        self.updateUnderline(with: xPosition)
        self.updateGradientLocations(with: xPosition, frameWidth: frameWidth)
    }
    
    ///Can Call from connected scrollview's scrollViewDidEndDecelerating method to update segment selection UI
    ///- parameter index: Int(scrollView.contentOffset.x / self.frame.width)
    public func updateSegmentSelection(with index: Int) {
        selectedSegmentIndex = index
        underlineSelector.frame.origin.x = segmentButtons[selectedSegmentIndex].frame.origin.x
    }
}

