//
//  MemoListTableViewController.swift
//  MemoApplication
//
//  Created by TJ on 01/08/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    //오른쪽의 + 버튼을 눌렀을 때 호출될 메소드
    @objc func add(_sender : Any){
        //인터페이스빌더에서 디자인 한 후 뷰 컨트롤러 인스턴스 만들기
        let memoFormViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemoFormViewController") as! MemoFormViewController
        //네비게이션을 이용해서 푸쉬
        self.navigationController?.pushViewController(memoFormViewController, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Memo List"
        //네비게이션 바의 오른쪽에 + 버튼을 추가해서 메소드를 설정.
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add(_sender:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
