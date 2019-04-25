//
//  CommonMethod.swift
//  Moms
//
//  Created by retygu on 15/12/24.
//  Copyright © 2015年 retygu. All rights reserved.
//

import UIKit

class CommonMethod: NSObject {
    
    // 获取label高度，加行间距
    func achieveLabelHeight(_ content: String, fontsize: CGFloat, contentWidth: CGFloat) -> CGFloat {
        let contetnLabel = UILabel(frame:CGRect(x: 10, y: 70, width: contentWidth, height: 20))
        contetnLabel.font = UIFont.systemFont(ofSize: fontsize)
        contetnLabel.numberOfLines = 0
        contetnLabel.lineBreakMode = NSLineBreakMode.byCharWrapping
        let attributedString = NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString.addAttributes([NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontsize), NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, content.count))
        contetnLabel.attributedText = attributedString
        contetnLabel.sizeToFit()
        
        return contetnLabel.frame.size.height
    }
    
    /// alterController 两个按钮 处理otherBtn事件
    ///
    /// - Parameters:
    ///   - currentVC: 当前控制器
    ///   - title: 标题
    ///   - meg: 提示消息
    ///   - cancelBtn: 取消按钮
    ///   - otherBtn: 其他按钮
    ///   - handler: 其他按钮处理事件
    static func showAlert(currentVC:UIViewController,title:String, meg:String, cancelBtn:String, otherBtn:String?, handler:((UIAlertAction) -> Void)?){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title:title,
                                                    message:meg ,
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title:cancelBtn, style: .cancel, handler:nil)
            
            alertController.addAction(cancelAction)
            
            if otherBtn != nil{
                let settingsAction = UIAlertAction(title: otherBtn, style: .default, handler: { (action) -> Void in
                    handler?(action)
                })
                alertController.addAction(settingsAction)
            }
            currentVC.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    /// 带输入框的alert
    ///
    /// - Parameters:
    ///   - currentVC: 当前视图
    ///   - title: title
    ///   - meg: 描述
    ///   - cancelBtn: 取消按钮
    ///   - otherBtn: 其他按钮
    ///   - handler: 返回
    static func showTFAlert(currentVC:UIViewController,title:String, meg:String, cancelBtn:String, otherBtn:String?, handler:((UIAlertAction, String) -> Void)?){
        DispatchQueue.main.async {
            var inputText: UITextField = UITextField()
            
            let alertController = UIAlertController(title:title,
                                                    message:meg ,
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title:cancelBtn, style: .cancel, handler:nil)
            
            alertController.addAction(cancelAction)
            
            if otherBtn != nil{
                let settingsAction = UIAlertAction(title: otherBtn, style: .default, handler: { (action) -> Void in
                    if(inputText.text != ""){
                        handler?(action, inputText.text!)
                    }else{
                        handler?(action, "")
                    }
                })
                alertController.addAction(settingsAction)
            }
            
            alertController.addTextField(configurationHandler: { (textField) in
                inputText = textField
                inputText.placeholder = "输入模块名称"
            })
            
            currentVC.present(alertController, animated: true, completion: nil)
        }
    }
    
    
//    static func photoCompression(imageArr:[UIImage]) -> [UIImage]  {
//
//        var newImageArr:[UIImage] = []
//
//        if imageArr.count > 0 {
//            for image in imageArr{
//                var data = image.jpegData(compressionQuality: 1)
//                print("before:\((data?.count)! / 1024)")
//                while data!.count / 1024 > 200 {
//                    data = image.jpegData(compressionQuality: 0.1)
//                }
//
//                print("after:\((data?.count)! / 1024)")
//                let newImage:UIImage? = UIImage(data: data!)
//                newImageArr.append(newImage!)
//            }
//        }
//
//        return newImageArr
//    }
    
    
    /// 获取当前的控制器
    ///
    /// - Returns: 当前viewcontroller
//    static func getCurrentVC() -> UIViewController? {
//        let kAppdelegate = UIApplication.shared.delegate as! AppDelegate
//        if let tabBar = kAppdelegate.window?.rootViewController as? UITabBarController {
//            let currentNav = tabBar.selectedViewController
//            if let currentNav = currentNav {
//                return currentNav.children.last!
//            } else {
//                return nil
//            }
//        }
//
//        return nil
//    }
}

extension String{
//    func ga_heightForReason() -> CGFloat {
//        let rect = NSString(string: self).boundingRect(with: CGSize(width: screen_width - 100, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont(name: "PingFang-SC-Medium", size: 16)!], context: nil)
//        
//        return ceil(rect.height)
//    }
    
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont(name: "PingFangSC-Regular", size: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font!], context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
}


extension Date{
    //MARK: - 获取日期各种值
    //MARK: 年
    func year() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: self)
        return com.year!
    }
    
    //MARK: 月
    func month() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: self)
        return com.month!
    }
    
    //MARK: 日
    func day() ->Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: self)
        return com.day!
    }
    
    //MARK: 时
    func hour() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: self)
        return com.hour!
    }
    
    //MARK: 分
    func minute() -> Int {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: self)
        return com.minute!
    }
    
    //MARK: 星期几
    func weekDay()->Int{
        let interval = Int(self.timeIntervalSince1970)
        let days = Int(interval/86400) // 24*60*60
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    
    //MARK: 当月天数
    func countOfDaysInMonth() ->Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self)
        return (range?.length)!
        
    }
    
    //MARK: 当月第一天是星期几
    func firstWeekDay() ->Int {
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let firstWeekDay = (calendar as NSCalendar?)?.ordinality(of: NSCalendar.Unit.weekday, in: NSCalendar.Unit.weekOfMonth, for: self)
        return firstWeekDay! - 1
        
    }
    
    //MARK: - 日期的一些比较
    //是否是今天
    func isToday()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month && com.day == comNow.day
    }
    
    //是否是这个月
    func isThisMonth()->Bool {
        let calendar = NSCalendar.current
        let com = calendar.dateComponents([.year,.month,.day], from: self)
        let comNow = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year == comNow.year && com.month == comNow.month
    }
    
    //是否是同一天
    func isThisDay(otherDay:Date) -> Bool {
        
        if self.year() == otherDay.year() && self.month() == otherDay.month() && self.day() == otherDay.day() {
            return true
        }else{
            return false
        }
    }
}


extension UIView{
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

extension UIImage {
    
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
}

