//
//  BeerCreateViewController.swift
//  BeerApp
//
//  Created by Alexander Karaatanasov on 26.09.20.
//  Copyright © 2020 Alexander Karaatanasov. All rights reserved.
//

import UIKit

class BeerCreateViewController: UIViewController {
    
    // MARK: - Vars
    
    var viewModel: BeerCreateDisplay!
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var typeTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var createButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    
    // MARK: - Private
    
    private func configureView() {
        title = NSLocalizedString("BeerCreateViewController.Title", comment: "Create a new beer title")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))

        nameTextField.tag = 0
        nameTextField.delegate = self
        nameTextField.placeholder = NSLocalizedString("BeerCreateViewController.BeerName.Placeholder", comment: "Beer name placeholder")
        
        typeTextField.tag = 1
        typeTextField.delegate = self
        typeTextField.placeholder = NSLocalizedString("BeerCreateViewController.BeerType.Placeholder", comment: "Beer type placeholder")
        
        descriptionTextField.tag = 2
        descriptionTextField.delegate = self
        descriptionTextField.placeholder = NSLocalizedString("BeerCreateViewController.BeerDescription.Placeholder", comment: "Beer description placeholder")
        
        createButton.titleLabel?.text = NSLocalizedString("BeerCreateViewController.Create.ButtonTitle", comment: "Beer creation button")
    }

    // MARK: - Actions
    
    @objc private func cancelTapped(_ sender: Any) {
        viewModel.cancelCreation(sender: self)
    }
    
    @IBAction private func createTapped(_ sender: Any) {
        guard
            let beerName = nameTextField.text,
            let beerType = typeTextField.text,
            let beerDescription = descriptionTextField.text
        else {
            return
        }
        
        let nameValid = viewModel.isBeerInputValid(for: beerName)
        let typeValid = viewModel.isBeerInputValid(for: beerType)
        let descriptionValid = viewModel.isBeerInputValid(for: beerDescription)
        
        colorBorder(for: nameTextField, ifInvalid: !nameValid)
        colorBorder(for: typeTextField, ifInvalid: !typeValid)
        colorBorder(for: descriptionTextField, ifInvalid: !descriptionValid)
        
        if nameValid, typeValid, descriptionValid {
            showActivityIndicatorAndHideButton()
            viewModel.createNewBeer(name: beerName, type: beerType, description: beerDescription, sender: self)
        }
    }

    // MARK: - Private UI Methods
    
    private func showActivityIndicatorAndHideButton() {
        let activityView = UIActivityIndicatorView(style: .medium)
        activityView.center = createButton.center
        view.addSubview(activityView)
        createButton.isHidden = true
        activityView.startAnimating()
    }
    
    private func colorBorder(for textField: UITextField, ifInvalid isInvalid: Bool) {
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        
        if isInvalid { // set red border
            textField.layer.borderColor = UIColor.red.cgColor
        } else { // reset clear border
            textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
}

// MARK: - Text Field Delegate

extension BeerCreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
}
