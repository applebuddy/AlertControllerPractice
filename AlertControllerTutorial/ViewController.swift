//
//  ViewController.swift
//  AlertControllerTutorial
//
//  Created by Min Kyeong Tae on 29/06/2019.
//  Copyright © 2019 Min Kyeong Tae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!

    var alertController = UIAlertController()
    var listOfUsers = ["Nimish"]
    var listOfPasswords = ["Pockey"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Default AlertController with Async Work

    @IBAction func firstButtonPressed(_: UIButton) {
        alertController = UIAlertController(title: "New Alert!", message: "Here is a new alert for you", preferredStyle: .alert)
        present(alertController, animated: true, completion: { ()
            // Alert가 나타나고 completion 클로저가 실행됨
            print("Alert is being displayed(completion closure Called)")
        })
        let delay = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: delay) { () -> Void in
            print("asyncAfter executed")
            self.alertController.dismiss(animated: true, completion: { () -> Void in
                print("Alert is being dismissed")
            })
        }
    }

    // MARK: - AlertController with multiple AlertActions

    @IBAction func secondButtonPressed(_: UIButton) {
        alertController = UIAlertController(title: "Alert 2", message: "Here is an Alert with Actions", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_: UIAlertAction) -> Void in
            print("cancelAction is Activated")
        })
        let blueAction = UIAlertAction(title: "Blue", style: .default, handler: { (_: UIAlertAction) -> Void in
            // blueAction이 실행 되면 뷰가 파란색이 된다.
            self.view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        })
        let redAction = UIAlertAction(title: "Red", style: .default, handler: { (_: UIAlertAction) -> Void in
            // redAction이 실행 되면 뷰가 빨강색이 된다.
            self.view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        })
        let greenAction = UIAlertAction(title: "Green", style: .default, handler: { (_: UIAlertAction) -> Void in
            self.view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        })
        alertController.addAction(greenAction)
        alertController.addAction(cancelAction)
        alertController.addAction(blueAction)
        alertController.addAction(redAction)

        // referredAction 설정을 하면 볼드체로 나옴
        alertController.preferredAction = greenAction

        present(alertController, animated: true, completion: { () -> Void in
            // ActionSeet가 나타나고 출력 됩
            print("Alert with actions is being displayed(completion closure Called)")
        })
    }

    // MARK: - Default Action Sheet

    @IBAction func thirdButtonPressed(_: UIButton) {
        alertController = UIAlertController(title: "Alert 3", message: "Here is Alert Text", preferredStyle: .actionSheet)
        present(alertController, animated: true, completion: { () -> Void in
            // ActionSeet가 나타나고 출력 됩
            print("ActionSheet is being displayed(completion closure Called)")
        })
        alertController.dismiss(animated: true, completion: { () -> Void in
            print("ActionSheet is being dismissed")
        })
    }

    // MARK: - Login Alert Controller

    @IBAction func fourthButtonPressed(_: UIButton) {
        alertController = UIAlertController(title: "Alert 4", message: "Here is an Alert with Actions", preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_: UIAlertAction) -> Void in
            print("cancelAction is Activated")
        })

        let loginAction = UIAlertAction(title: "Login", style: .default, handler: { (_: UIAlertAction) -> Void in
            print("Login has been cancelled")
            guard let textFields = self.alertController.textFields else {
                print("No text fields on alert controller")
                return
            }
            guard let userNameText = textFields[0].text else {
                print("No username entered")
                return
            }
            guard let passwordText = textFields[1].text else {
                print("No password entered")
                return
            }
            // 사용자 로그인 정보가 일치하는지 확인한다.
            if userNameText == self.listOfUsers[0], passwordText == self.listOfPasswords[0] {
                print("Login successful! ^-^")
                self.firstLabel.text = "Welcome \(self.listOfUsers[0])"
                self.secondLabel.text = "Current password: \(self.listOfPasswords[0])"
            } else {
                print("Incorrect username or password")
                self.firstLabel.text = "Incoreect username or password"
                self.alertController.dismiss(animated: true, completion: nil)
            }
        })

        alertController.addAction(cancelAction)
        alertController.addAction(loginAction)
        alertController.addTextField(configurationHandler: { (TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "Username here"
            TEXTFIELD.autocapitalizationType = .sentences
//            // * 접근식별자 설정방법
//            TEXTFIELD.accessibilityIdentifier = "textField"
        })
        alertController.addTextField(configurationHandler: { (TEXTFIELD: UITextField) -> Void in
            TEXTFIELD.placeholder = "Password here"
            TEXTFIELD.isSecureTextEntry = true
        })

        alertController.view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        alertController.view.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

        present(alertController, animated: true, completion: { () -> Void in
            // ActionSeet가 나타나고 출력 됩
            print("Alert with actions is being displayed(completion closure Called)")
        })
    }
}
