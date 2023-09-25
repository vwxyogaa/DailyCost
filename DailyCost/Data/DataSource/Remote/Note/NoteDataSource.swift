//
//  NoteDataSource.swift
//  DailyCost
//
//  Created by Panji Yoga on 19/09/23.
//

import Foundation
import RxSwift

final class NoteDataSource {
    func getCatatan(id: Int) -> Observable<NoteResponse> {
        let url = URL(string: "https://dailycost.my.id/api/catatan/\(id)")!
        let data: Observable<NoteResponse> = APIManager.shared.executeQuery(url: url, method: .get)
        return data
    }
}
