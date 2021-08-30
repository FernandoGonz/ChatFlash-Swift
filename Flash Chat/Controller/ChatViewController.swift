//
//  ChatViewController.swift
//  Flash Chat
//
//  Created by Fernando González on 26/08/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = [
        Message(sender: "sury@gmail.com", body: "Hey!!"),
        Message(sender: "ing.fernandogonzalez@gmail.com", body: "What's up men!")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = K.appName
        navigationItem.hidesBackButton = true
        
        // tableView.delegate = self (NOT necessary for this project)
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func logOutBtnPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            // Go to the root of the Navigation Stack
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UITableViewDelegate

// UITableViewDataSource is responsible to fill the tableView with the information cells
extension ChatViewController: UITableViewDataSource {
    // This methods employes of many rows should have and return it
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    // Returns a TableViewCell. IndexPath is the position
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Creating a UITableViewCell (a row)
        let cell: MessageCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        // Adding text to the label
        cell.messageLabel.text = "\(messages[indexPath.row].body)"
        
    
        return cell
    }
    
}

//MARK: - UITableViewDelegate
// NOTE: for this project, UITableViewDelegate is not necessary!
//extension ChatViewController: UITableViewDelegate {
//
//    /** Tells to the delegate row is selected */
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//
//}
