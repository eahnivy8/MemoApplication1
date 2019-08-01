//
//  MemoReadViewController.swift
//  MemoApplication
//
//  Created by TJ on 01/08/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class MemoReadViewController: UIViewController {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    //상위 뷰 컨트롤러로부터 데이터를 넘겨받기 위한 변수
    var memoVO : MemoValueObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subject.text = memoVO?.title
        contents.text = memoVO?.content
        img.image = memoVO?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm 작성"
        let dateString = formatter.string(from: (memoVO?.regdate)!)
        self.navigationItem.title = dateString
    }
    

}
