//
//  AppColor+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

private enum AppColor: String {
    case primary100, accent100, accent200, accent300, accent400, accent401, bg100, bg200, bg300, text100, text200
}

private extension AppColor {
    private func color(named: String) -> UIColor {
        return UIColor.defaultColor(named: named)
    }
    
    private var title: String {
        return self.rawValue
    }
    
    var color: UIColor {
        switch self {
        case .primary100:
            return color(named: AppColor.primary100.title)
        case .accent100:
            return color(named: AppColor.accent100.title)
        case .accent200:
            return color(named: AppColor.accent200.title)
        case .accent300:
            return color(named: AppColor.accent300.title)
        case .accent400:
            return color(named: AppColor.accent400.title)
        case .accent401:
            return color(named: AppColor.accent401.title)
        case .bg100:
            return color(named: AppColor.bg100.title)
        case .bg200:
            return color(named: AppColor.bg200.title)
        case .bg300:
            return color(named: AppColor.bg300.title)
        case .text100:
            return color(named: AppColor.text100.title)
        case .text200:
            return color(named: AppColor.text200.title)
        }
    }
}

let _defaultColors : [String:UIColor] = [
    "primary100" : UIColor(red: 63/255, green: 205/255, blue: 111/255, alpha: 1),
    "accent100" : UIColor(red: 29/255, green: 167/255, blue: 76/255, alpha: 1),
    "accent200" : UIColor(red: 89/255, green: 231/255, blue: 137/255, alpha: 1),
    "accent300" : UIColor(red: 255/255, green: 72/255, blue: 72/255, alpha: 1),
    "accent400" : UIColor(red: 255/255, green: 191/255, blue: 171/255, alpha: 1),
    "accent401" : UIColor(red: 165/255, green: 233/255, blue: 188/255, alpha: 0.3),
    "bg100" : UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1),
    "bg200" : UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1),
    "bg300" : UIColor(red: 41/255, green: 45/255, blue: 50/255, alpha: 0.5),
    "text100" : UIColor(red: 174/255, green: 174/255, blue: 174/255, alpha: 1),
    "text200" : UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
]

extension UIColor {
    static func defaultColor(named name: String, default defaultColor: UIColor = .black) -> UIColor {
        if #available(iOS 11, *) {
            return UIColor(named: name) ?? defaultColor
        }
        else {
            return _defaultColors[name] ?? defaultColor
        }
    }
    
    public class var primary100: UIColor {
        return AppColor.primary100.color
    }
    
    public class var accent100: UIColor {
        return AppColor.accent100.color
    }
    
    public class var accent200: UIColor {
        return AppColor.accent200.color
    }
    
    public class var accent300: UIColor {
        return AppColor.accent300.color
    }
    
    public class var accent400: UIColor {
        return AppColor.accent400.color
    }
    
    public class var accent401: UIColor {
        return AppColor.accent401.color
    }
    
    public class var bg100: UIColor {
        return AppColor.bg100.color
    }
    
    public class var bg200: UIColor {
        return AppColor.bg200.color
    }
    
    public class var bg300: UIColor {
        return AppColor.bg300.color
    }
    
    public class var text100: UIColor {
        return AppColor.text100.color
    }
    
    public class var text200: UIColor {
        return AppColor.text200.color
    }
}
