//
//  RecentlyActivity.swift
//  DailyCost
//
//  Created by Panji Yoga on 22/09/23.
//

enum ActivityType {
    case income
    case expense
}

struct ActivityModel {
    let id: Int?
    let name: String?
    let date: String?
    let amount: Int?
    let category: String?
    let type: ActivityType
}
