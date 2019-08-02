//
//  SideBarVC.swift
//  MemoApplication
//
//  Created by TJ on 02/08/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class SideBarVC: UITableViewController {
    let titles = ["새글 작성하기", "계정관리"]
    let icons = [UIImage(named: "icon01.png"), UIImage(named: "icon02.png")]
// header view를 위한 인스턴스를 생성
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //헤더뷰로 사용할 뷰를 생성
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width:self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.blue
        self.tableView.tableHeaderView = headerView
        //이름 레이블 만들기
        nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        nameLabel.text = "EA"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.backgroundColor = UIColor.clear
        headerView.addSubview(nameLabel)
        //email 레이블 만들기
        emailLabel.frame = CGRect(x: 70, y: 35, width: 100, height: 30)
        emailLabel.text = "EA"
        emailLabel.textColor = UIColor.white
        emailLabel.font = UIFont.boldSystemFont(ofSize: 10)
        emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(emailLabel)
        
        profileImage.image = UIImage(named:"account.jpg")
        profileImage.frame = CGRect(x:10, y:10, width: 50, height: 50)
        //라운드 처리
        profileImage.layer.cornerRadius = (profileImage.frame.width/2)
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.red.cgColor
        
        //그림자 효과
        profileImage.layer.masksToBounds = true
        headerView.addSubview(self.profileImage)

    }

//행 갯수 설정
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
//셀 출력 메소드 작성
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.imageView?.image = icons[indexPath.row]
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //목적지 뷰 컨트롤러
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "MemoFormViewController") as! MemoFormViewController
            //네비게이션 컨트롤러 가져오기
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            //화면이동.
            target.pushViewController(destination, animated: true)
            //메뉴를 숨김.
            self.revealViewController()?.revealToggle(self)
    }
}
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
