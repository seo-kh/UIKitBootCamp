//
//  ViewController.swift
//  UIKitBootCamp
//
//  Created by james seo on 2023/03/14.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UICOMPONENTS
    private var stackView: UIStackView!
    private var spacingSlider: UISlider!
    private var spacingTitle: UILabel!
    private var axisSegmentButton: UISegmentedControl!
    private var axisTitle: UILabel!
    private var buttons: UIScrollView!
    private var distributionTitle: UILabel!
    private var alignmentPicker: UIPickerView!
    private var alignmentLabel: UILabel!
    
    // MARK: - HELPER
    private let distributions = ["fill", "fillEqually", "fillProportionally", "equalSpacing", "equalCentering"]
    private let alignments = ["fill", "leading", "firstBaseline", "center", "trailing", "lastBaseline", "top", "bottom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStackView()
        setupSliderView()
        setupSpacingTitleView()
        setupAxisSegmentButtonView()
        setupAxisTitleView()
        setupDistributionButtonsView()
        setupDistributionTitleView()
        setupAlignmentPickerView()
        setupAlignmentTitleView()
    }
}

// MARK: - VIEW FUNCITON
extension ViewController {
    @objc func didSlide(_ sender: UISlider) {
        self.stackView.spacing = CGFloat(spacingSlider.value)
        self.spacingTitle.text = String(format: "Spacing: %.2f", spacingSlider.value)
    }
    
    @objc func didAxisSegmentTap(_ sender: UISegmentedControl) {
        self.axisTitle.text = "Axis: \(sender.selectedSegmentIndex == 0 ? "horizontal" : "vertical")"
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.stackView.axis = sender.selectedSegmentIndex == 0 ? .horizontal : .vertical
        }
    }
    
    @objc func didDistributionButton(_ sender: UIButton) {
        self.stackView.distribution = UIStackView.Distribution.init(rawValue: sender.tag)!
        self.distributionTitle.text = "Distribution: " + distributions[sender.tag]
    }
}

// MARK: - VIEW SETTING
private extension ViewController {
    func setupStackView() {
        // 1. assign
        stackView = UIStackView()
        
        // 2. addSubview
        view.addSubview(stackView)
        
        // 3. attributes
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.layer.zPosition = 0
        
        // 4. auto-layout
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0)
        ])
        
        // 5. etc
        [UIColor.red, UIColor.green, UIColor.blue]
            .forEach({ (color: UIColor) in
                let view = UIView()
                view.backgroundColor = color
                view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    view.widthAnchor.constraint(equalToConstant: .random(in: 50..<200)),
                    view.heightAnchor.constraint(equalToConstant: .random(in: 50..<200)),
                ])
                stackView.addArrangedSubview(view)
            })
    }
    
    func setupSliderView() {
        // 1. assign view
        spacingSlider = UISlider()
        // 2. addSubview
        view.addSubview(spacingSlider)
        // 3. attributes
        spacingSlider.translatesAutoresizingMaskIntoConstraints = false
        spacingSlider.maximumValue = 30.0
        spacingSlider.minimumValue = 0.0
        spacingSlider.setValue(12.0, animated: true)
        spacingSlider.addTarget(self, action: #selector(didSlide), for: .valueChanged)
        // 4. auto-layout
        NSLayoutConstraint.activate([
            spacingSlider.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20.0),
            spacingSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spacingSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
        ])
        // 5. etc
    }
    
    func setupSpacingTitleView() {
        // 1. assign view
        spacingTitle = UILabel()
        // 2. addSubview
        view.addSubview(spacingTitle)
        // 3. attributes
        spacingTitle.translatesAutoresizingMaskIntoConstraints = false
        spacingTitle.text = "Spacing: \(12.0)"
        // 4. auto-layout
        NSLayoutConstraint.activate([
            spacingTitle.bottomAnchor.constraint(equalTo: spacingSlider.topAnchor, constant: -4.0),
            spacingTitle.leadingAnchor.constraint(equalTo: spacingSlider.leadingAnchor)
        ])
        // 5. etc
    }
    
    func setupAxisSegmentButtonView() {
        // 1. assign view
        axisSegmentButton = UISegmentedControl(items: ["horizontal", "vertical"])
        // 2. addSubview
        view.addSubview(axisSegmentButton)
        // 3. attributes
        axisSegmentButton.selectedSegmentIndex = 0
        axisSegmentButton.addTarget(self, action: #selector(didAxisSegmentTap), for: .valueChanged)
        axisSegmentButton.translatesAutoresizingMaskIntoConstraints = false
        // 4. auto-layout
        NSLayoutConstraint.activate([
            axisSegmentButton.bottomAnchor.constraint(equalTo: spacingTitle.topAnchor, constant: -20.0),
            axisSegmentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            axisSegmentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        // 5. etc
    }
    
    func setupAxisTitleView() {
        // 1. assign view
        axisTitle = UILabel()
        // 2. addSubview
        view.addSubview(axisTitle)
        // 3. attributes
        axisTitle.translatesAutoresizingMaskIntoConstraints = false
        axisTitle.text = "Axis: horizontal"
        // 4. auto-layout
        NSLayoutConstraint.activate([
            axisTitle.leadingAnchor.constraint(equalTo: spacingTitle.leadingAnchor),
            axisTitle.bottomAnchor.constraint(equalTo: axisSegmentButton.topAnchor, constant: -4.0)
        ])
        // 5. etc
    }
    
    func setupDistributionButtonsView() {
        // 1. assign view
        buttons = UIScrollView()
        let buttonStack = UIStackView()
        // 2. addSubview
        buttons.addSubview(buttonStack)
        self.view.addSubview(buttons)
        // 3. attributes
        buttons.translatesAutoresizingMaskIntoConstraints = false
        buttons.showsHorizontalScrollIndicator = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillProportionally
        buttonStack.spacing = 8.0
        buttonStack.alignment = .center
        // 4. auto-layout
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: buttons.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: buttons.trailingAnchor),
            buttonStack.topAnchor.constraint(equalTo: buttons.topAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: buttons.bottomAnchor),
            buttonStack.widthAnchor.constraint(greaterThanOrEqualTo: buttons.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            buttons.leadingAnchor.constraint(equalTo: axisTitle.leadingAnchor),
            buttons.bottomAnchor.constraint(equalTo: axisTitle.topAnchor, constant: -20.0),
            buttons.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor),
            buttons.heightAnchor.constraint(equalToConstant: 40.0),
        ])
        // 5. etc
        distributions
            .enumerated()
            .forEach({ (index: Int, dist: String) in
                var configuration = UIButton.Configuration.borderedTinted()
                configuration.title = dist
                let button = UIButton(configuration: configuration)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.tag = index
                button.layer.cornerRadius = 8.0
                button.addTarget(self, action: #selector(didDistributionButton), for: .touchUpInside)
                buttonStack.addArrangedSubview(button)
            })
    }
    
    func setupDistributionTitleView() {
        // 1. assign view
        distributionTitle = UILabel()
        // 2. addSubview
        view.addSubview(distributionTitle)
        // 3. attributes
        distributionTitle.text = "Distribution: equalSpacing"
        distributionTitle.translatesAutoresizingMaskIntoConstraints = false
        // 4. auto-layout
        NSLayoutConstraint.activate([
            distributionTitle.leadingAnchor.constraint(equalTo: buttons.leadingAnchor),
            distributionTitle.bottomAnchor.constraint(equalTo: buttons.topAnchor, constant: -4.0)
        ])
        // 5. etc
    }
    
    func setupAlignmentPickerView() {
        // 1. assign view
        alignmentPicker = UIPickerView()
        // 2. addSubview
        view.addSubview(alignmentPicker)
        // 3. attributes
        alignmentPicker.translatesAutoresizingMaskIntoConstraints = false
        alignmentPicker.delegate = self
        alignmentPicker.dataSource = self
        // 4. auto-layout
        NSLayoutConstraint.activate([
            alignmentPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alignmentPicker.bottomAnchor.constraint(equalTo: distributionTitle.topAnchor, constant: -20.0),
            alignmentPicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            alignmentPicker.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        // 5. etc
    }
    
    func setupAlignmentTitleView() {
        // 1. assign view
        alignmentLabel = UILabel()
        // 2. addSubview
        view.addSubview(alignmentLabel)
        // 3. attributes
        alignmentLabel.translatesAutoresizingMaskIntoConstraints = false
        alignmentLabel.text = "Alignment: equalSpacing"
        // 4. auto-layout
        NSLayoutConstraint.activate([
            alignmentLabel.leadingAnchor.constraint(equalTo: distributionTitle.leadingAnchor),
            alignmentLabel.bottomAnchor.constraint(equalTo: alignmentPicker.topAnchor, constant: -4.0)
        ])
        // 5. etc
    }
}

// MARK: - PICKER VIEW SETTING
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        alignments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        alignments[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        alignmentLabel.text = "Alignment: " + alignments[row]
        switch row {
        case 6:
            stackView.alignment = .top
        case 7:
            stackView.alignment = .bottom
        default:
            stackView.alignment = .init(rawValue: row)!
        }
    }
}
