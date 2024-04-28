//
//  ViewController.swift
//  myLibrary
//
//  Created by Nojood Aljuaid  on 17/10/1445 AH.
//

import UIKit
import Alamofire
struct Todo : Decodable {
    var id : Int
    var title : String
}

class ViewController: UIViewController {

    
    
    @IBOutlet weak var todosTableView: UITableView!
    
    var arr : [Todo] = []
    var dict = ["title" : "my first day"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todosTableView.dataSource = self
        AF.request("https://jsonplaceholder.typicode.com/todos").responseDecodable(of: [Todo].self ,  completionHandler: { response in
            guard  let todos = response.value else { return }
            self.arr = todos
           
            self.todosTableView.reloadData()
        })
        
        AF.request("https://jsonplaceholder.typicode.com/todos" , method: .post , parameters: dict , encoder: JSONParameterEncoder.default) .responseJSON { response in
            guard let todos = response.value else {return}
            print(todos)
        }
        
    }

}


extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = arr[indexPath.row].title
        return cell
    }
    
    
}
