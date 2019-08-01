//
//  MemoFormViewController.swift
//  MemoApplication
//
//  Created by TJ on 01/08/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class MemoFormViewController: UIViewController{
    //제목을 저장할 변수
    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preView: UIImageView!
    @IBAction func save(_ sender: Any) {
        //대화상자 customizing을 위한 viewcontroller
        let customAlertView = UIViewController()
        customAlertView.view = UIImageView(image:UIImage(named: "warning-icon-60"))
        //인스턴스? 내용1 ?? 내용2
        //인스턴스가 nil이 아니면 내용1 nil이면 내용2
        customAlertView.preferredContentSize = UIImage(named: "warning-icon-60")? .size ?? CGSize.zero
        
        //입력한 내용이 없으면 return
        guard self.contents.text.isEmpty == false else{
            let alert = UIAlertController(title: "Contents Required", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style: .cancel))
            alert.setValue(customAlertView, forKey:"contentViewController")
            self.present(alert, animated: true)
            return
        }
        //데이터를 저장할 VO인스턴스를 생성
        let data = MemoValueObject()
        data.title = subject
        data.content = contents.text
        data.image = preView.image
        data.regdate = Date()
        //공유 객체에 데이터 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.insert(data, at: 0)
        //이전 뷰 컨트롤러로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pick(_ sender: Any) {
        //카메라, 저장앨범, 사진 라이브러리 중의 하나를 선택하는 대화상자를 출력
        let select = UIAlertController(title: "Choose Where to Import Images", message: nil, preferredStyle: .actionSheet)
        select.addAction(UIAlertAction(title:"Camera", style: .default, handler:{(alert) -> Void in
            self.presentImagePicker(.camera)}))
        select.addAction(UIAlertAction(title:"Saved Photo Album", style: .default, handler:{(alert) -> Void in
            self.presentImagePicker(.savedPhotosAlbum)}))
        select.addAction(UIAlertAction(title:"Photo Library", style: .default, handler:{(alert) -> Void in
            self.presentImagePicker(.photoLibrary)}))
        self.present(select, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contents.delegate = self
        
        //배경 이미지 설정
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"memo-background.png")!)
        //텍스트 뷰의 속성을 수정
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.layer.backgroundColor = UIColor.clear.cgColor
        //줄 간격 조정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [NSAttributedString.Key.paragraphStyle:style])
        self.contents.text = ""
    }
    //image picker를 출력해줄 사용자 정의 메소드
    //조건에 맞지 않을때 더이상 수행하지 않도록 하고자 할 때 guard를 사용함.
    func presentImagePicker(_ source: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(source) == true else{
            let alert = UIAlertController(title:"Unavailable Type", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "confirm", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
            return
        }
        //image picker 만들어서 출력하기
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        
        self.present(picker, animated: true)
        
        
    }


}

extension MemoFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //image를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지를 이미지 뷰에 출력
        self.preView.image =
        info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        //이미지 피커 닫기
        picker.dismiss(animated: true)
    }
}

extension MemoFormViewController: UITextViewDelegate{
    //텍스트 뷰의 내용이 변경될 때 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용을 읽어오기
        //String은 NSString으로 종종 변경해서 사용하는데, 그 이유는 NSString에는
        //문자열 관련 메소드가 많고 사용하기 쉬운 편인데, swift의 String은 메소드 사용법이 까다롭기 때문.
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        //문자열 잘라내기
        self.subject = contents.substring(with:NSRange(location: 0, length: length))
        //잘라진 문자열을 네비게이션 바에 출력.
        self.navigationItem.title = subject
    }
}
