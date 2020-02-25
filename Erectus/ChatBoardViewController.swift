//
//  ChatBoardViewController.swift
//  Erectus
//
//  Created by Alexey on 04/02/2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit
import CoreData


class ChatBoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var usersInChatBoard = [FriendItem]()
    @IBOutlet weak var chatBoard: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersInChatBoard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatBoard.dequeueReusableCell(withIdentifier: "cellIndentifer", for: indexPath)
        cell.textLabel?.text = usersInChatBoard[indexPath.row].nickName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatRoomController = storyboard?.instantiateViewController(withIdentifier: "ChatRoom") as! ChatRoomViewController
        chatRoomController.modalPresentationStyle = .fullScreen
        chatRoomController.thisChatId = usersInChatBoard[indexPath.row].chatId
        present(chatRoomController, animated: true, completion: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        /*
        let peoples = NSEntityDescription.entity(forEntityName: "Friend", in: context)
        
        let newPeopl = NSManagedObject(entity: peoples!, insertInto: context)
        newPeopl.setValue(Date.init(), forKey: "dateTimeLastMessage")
        newPeopl.setValue("SUCKA", forKey: "nickname")
        newPeopl.setValue("2212", forKey: "chatID")
        try! context.save()
        */
        self.getData()
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [NSSortDescriptor(key: "dateTimeLastMessage", ascending: true)]
        do{
            
            let result = try! context.fetch(request)
            for date in result as! [NSManagedObject]{
    
                print(date.value(forKey: "nickname"))
                self.usersInChatBoard += [FriendItem.init(chatId_: date.value(forKey: "chatID") as! String, lastMessage_: "HUI", countOfUnreadMessages_: 1, dataTimeLastMessage_: date.value(forKey: "dateTimeLastMessage") as! Date, nickname_: date.value(forKey: "nickname") as! String)]
            }
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
