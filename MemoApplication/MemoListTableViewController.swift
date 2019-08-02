

import UIKit

class MemoListTableViewController: UITableViewController {
    //AppDelegate에 대한 참조
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        
        //샘플 데이터 생성
        let memo1 = MemoValueObject()
        memo1.title = "Country Tour"
        memo1.content = "Things to Prepare"
        memo1.regdate = Date() //오늘 날짜 대입
        appDelegate.memoList.append(memo1)
        
        let memo2 = MemoValueObject()
        memo2.title = "Meeting with CEO"
        memo2.content = "HQ on 8/14/2019"
        memo2.regdate = Date(timeIntervalSinceNow: 6000)
        appDelegate.memoList.append(memo2)
        //if 나 guard 구문에서 메소드의 실행 결과나 변수를 이용해서 상수를 생성하는 구문을 작성하면,
        //실행 결과나 변수가 nil이면 {} 안의 내용을 수행하지 않고 nil이 아니면 수행.
        if let revealVC = self.revealViewController(){
            let sideBarBtn = UIBarButtonItem()
            sideBarBtn.image = UIImage(named: "sidemenu.png")
            sideBarBtn.target = revealVC
            sideBarBtn.action = #selector(revealVC.revealToggle(_:))
            self.navigationItem.leftBarButtonItem = sideBarBtn
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    //화면에 다시 출력될 때 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //테이블 뷰가 데이터를 다시 출력.
        tableView.reloadData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appDelegate.memoList.count
    }
    //셀을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //행 번호에 해당하는 데이터
        let row = appDelegate.memoList[indexPath.row]
        //이미지가 있으면 셀 id는 MemoCellwithImage. 이미지가 없으면 셀 id는 MemoCell
        let cellID = row.image == nil ? "MemoCell" : "MemoCellWithImage"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MemoCell
        //내용출력
        cell.subject.text = row.title
        cell.contents.text = row.content
        //날짜는 바로 출력이 불가능하여 dateformmater를 이용해야 함.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate.text = formatter.string(from: row.regdate!)
        cell.img?.image = row.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //하위 뷰 컨틀롤러를 만들기
        let memoReadVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoReadViewController") as! MemoReadViewController
        memoReadVC.memoVO = appDelegate.memoList[indexPath.row]
        self.navigationController?.pushViewController(memoReadVC, animated: true)
    }
}
