//
//  DataMapper.swift
//  DailyCost
//
//  Created by Panji Yoga on 07/09/23.
//

final class DataMapper {
    static func mapRegisterResponseToModel(data: RegisterResponse) -> RegisterModel {
        return RegisterModel(
            message: data.message,
            token: data.token,
            dataId: data.data?.id
        )
    }
    
    static func mapLoginResponseToModel(data: LoginResponse) -> LoginModel {
        return LoginModel(
            status: data.status,
            token: data.token,
            dataId: data.data?.id,
            dataNama: data.data?.nama
        )
    }
    
    static func mapDepoResponseToModel(data: DepoResponse) -> DepoModel {
        return DepoModel(
            status: data.status,
            message: data.message,
            dataUserId: data.data?.userId,
            dataUangGopay: data.data?.uangGopay,
            dataUangCash: data.data?.uangCash,
            dataUangRekening: data.data?.uangRekening
        )
    }
}
