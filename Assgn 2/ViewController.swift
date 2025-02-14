//
//  ViewController.swift
//  Assgn 2
//
//  Created by Mayank Jangid on 2/13/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
        @IBAction func submitTapped(_ sender: UIButton) {
            //Checking the no.
            guard let text = numberTextField.text,
                  let number = Int(text),
                  number > 0 else {
                showAlert(message: "Please enter a + no.")
                return
            }
            
            performSegue(withIdentifier: K.tableViewSegue, sender: number)
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == K.tableViewSegue {
                if let destinationVC = segue.destination as? TableViewController,
                   let number = sender as? Int {
                    destinationVC.maxNumber = number
                }
            }
        }
    
        //when u enter anything other than + no.
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
}
