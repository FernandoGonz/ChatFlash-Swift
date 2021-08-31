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
    
    var messages: [Message] = []
    
    // creating an instance of Firestore
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = K.appName
        navigationItem.hidesBackButton = true
        
        // tableView.delegate = self (NOT necessary for this project)
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField, descending: false).addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from firestore: \(e.localizedDescription)")
            } else {
                if let snapshotDocuments: [QueryDocumentSnapshot] = querySnapshot?.documents {
                    for document: QueryDocumentSnapshot in snapshotDocuments {
                        // document.data() this return an dictionary for each document [sender: value, message: value]
                        let data: [String: Any] = document.data()
                        if let sender: String = data[K.FStore.senderField] as? String, let body: String = data[K.FStore.bodyField] as? String {
                            let newMessage: Message = Message(sender: sender, body: body)
                            self.messages.append(newMessage)
            
                            // Refreshing tableView
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
       
        // Use the code below only when you need ONE document
//        db.collection(K.FStore.collectionName).getDocuments { querySnapshot, error in
//            if let e = error {
//                print("There was an issue retrieving data from firestore: \(e.localizedDescription)")
//            } else {
//                if let snapshotDocuments: [QueryDocumentSnapshot] = querySnapshot?.documents {
//                    for document: QueryDocumentSnapshot in snapshotDocuments {
//                        // document.data() this return an dictionary for each document [sender: value, message: value]
//                        let data: [String: Any] = document.data()
//                        if let sender: String = data[K.FStore.senderField] as? String, let body: String = data[K.FStore.bodyField] as? String {
//                            let newMessage: Message = Message(sender: sender, body: body)
//                            self.messages.append(newMessage)
//
//                            // Refreshing tableView
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData()
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
    @IBAction func sendBtnPressed(_ sender: UIButton) {
        if let messageBody: String = messageTextField.text, let messageSender: String = Auth.auth().currentUser?.email {
            // messageBody and MessageSender are not nil
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) { error in
                if let e = error {
                    print("There was an issue saving data on firestore: \(e.localizedDescription)")
                } else {
                    print("Successfully saved data!.")
                }
            }
        }
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
