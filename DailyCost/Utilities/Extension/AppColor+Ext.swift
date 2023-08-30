//
//  AppColor+Ext.swift
//  DailyCost
//
//  Created by Panji Yoga on 30/08/23.
//

import UIKit

private enum AppColor: String {
    case primary100, primary200, primary300, accent100, accent200, bg100, bg200, bg300, text100, text200
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
        case .primary200:
            return color(named: AppColor.primary200.title)
        case .primary300:
            return color(named: AppColor.primary300.title)
        case .accent100:
            return color(named: AppColor.accent100.title)
        case .accent200:
            return color(named: AppColor.accent200.title)
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
    "primary100" : UIColor(red: 1/255, green: 155/255, blue: 152/255, alpha: 1),
    "primary200" : UIColor(red: 85/255, green: 204/255, blue: 201/255, alpha: 1),
    "primary300" : UIColor(red: 193/255, green: 255/255, blue: 255/255, alpha: 1),
    "accent100" : UIColor(red: 221/255, green: 0/255, blue: 37/255, alpha: 1),
    "accent200" : UIColor(red: 255/255, green: 191.255, blue: 171/255, alpha: 1),
    "bg100" : UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1),
    "bg200" : UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1),
    "bg300" : UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1),
    "text100" : UIColor(red: 1/255, green: 78/255, blue: 96/255, alpha: 1),
    "text200" : UIColor(red: 63/255, green: 122/255, blue: 141/255, alpha: 1)
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
    
    public class var primary200: UIColor {
        return AppColor.primary200.color
    }
    
    public class var primary300: UIColor {
        return AppColor.primary300.color
    }
    
    public class var accent100: UIColor {
        return AppColor.accent100.color
    }
    
    public class var accent200: UIColor {
        return AppColor.accent200.color
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

