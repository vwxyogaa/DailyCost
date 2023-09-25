//
//  NoteRepository.swift
//  DailyCost
//
//  Created by Panji Yoga on 19/09/23.
//

import Foundation
import RxSwift

protocol NoteRepositoryProtocol {
    func getCatatan(id: Int) -> Observable<NoteModel>
}

final class NoteRepository {
    typealias NoteInstance = (NoteDataSource) -> NoteRepository
    fileprivate let remote: NoteDataSource
    
    init(remote: NoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: NoteInstance = { remote in
        return NoteRepository(remote: remote)
    }
}

extension NoteRepository: NoteRepositoryProtocol {
    func getCatatan(id: Int) -> Observable<NoteModel> {
        return remote.getCatatan(id: id)
            .map({ DataMapper.mapNoteResponseToModel(data: $0) })
    }
}
