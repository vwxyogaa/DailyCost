//
//  CatatanRepository.swift
//  DailyCost
//
//  Created by Panji Yoga on 19/09/23.
//

import Foundation
import RxSwift

protocol CatatanRepositoryProtocol {
    func getCatatan(id: Int) -> Observable<NoteModel>
}

final class CatatanRepository {
    typealias CatatanInstance = (CatatanDataSource) -> CatatanRepository
    fileprivate let remote: CatatanDataSource
    
    init(remote: CatatanDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: CatatanInstance = { remote in
        return CatatanRepository(remote: remote)
    }
}

extension CatatanRepository: CatatanRepositoryProtocol {
    func getCatatan(id: Int) -> Observable<NoteModel> {
        return remote.getCatatan(id: id)
            .map({ DataMapper.mapNoteResponseToModel(data: $0) })
    }
}
