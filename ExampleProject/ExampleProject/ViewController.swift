//
//  ViewController.swift
//  ExampleProject
//
//  Created by Lusine Magauzyan on 08.11.22.
//

import UIKit
import UnderlineSegmentedControl

class ViewController: UIViewController {
    
    private lazy var underlineSegmentedControl: UnderlineSegmentControl = {
        let control = UnderlineSegmentControl(with: ["First", "Second", "Third", "Fourth"])
        control.addTarget(self, action: #selector(segmentSelected(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureScrollView()

    }

    func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.size.width*4, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        let colors: [UIColor] = [.yellow, .green, .cyan, .purple]
        for x in 0..<4 {
            let page = UIView(frame: CGRect(x: CGFloat(x) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
            page.backgroundColor = colors[x]
            contentView.addSubview(page)
        }
    }
    
    func setupUI() {
        view.addSubview(underlineSegmentedControl)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            underlineSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            underlineSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            underlineSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            underlineSegmentedControl.heightAnchor.constraint(equalToConstant: 44),
            
            scrollView.topAnchor.constraint(equalTo: underlineSegmentedControl.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])

        let contentViewCenterX = contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        contentViewCenterX.priority = .defaultLow

        let contentViewWidth = contentView.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor)
        contentViewWidth.priority = .defaultLow

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentViewCenterX,
            contentViewWidth
        ])
    }
    
    @objc private func segmentSelected(_ segmentedControl: UnderlineSegmentControl) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(segmentedControl.selectedSegmentIndex) * view.frame.size.width, y: 0.0), animated: true)

    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        underlineSegmentedControl.updateSegmentSelectionInteractive(with: scrollView.contentOffset.x, frameWidth: scrollView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        underlineSegmentedControl.updateSegmentSelection(with: Int(scrollView.contentOffset.x / scrollView.frame.width))
    }
}



