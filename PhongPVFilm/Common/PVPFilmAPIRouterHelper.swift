//
//  PVPFilmAPIRouterHelper.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 07/03/2024.
//

import Foundation

class PVPFilmAPIRouterHelper {

    static
    func decodingToObject<T: Decodable>(_ data: Data,
                                        _ type: T.Type,
                                        errorMessage: String = PVPFilmError.genericError,
                                        isDebug: Bool = false
    ) throws -> T {
        if isDebug {
            let debugR = String(decoding: data, as: UTF8.self)
            print(debugR)
        }
        guard let model = try? JSONDecoder().decode(T.self, from: data) else {
            throw PVPFilmError.localError(message: errorMessage)
        }
        return model
    }
    
    static
    func decodingToListObject<T: Decodable>(_ data: Data,
                                            _ type: T.Type,
                                            errorMessage: String = PVPFilmError.genericError,
                                            isDebug: Bool = false
    ) throws -> [T] {
        if isDebug {
            let debugR = String(decoding: data, as: UTF8.self)
            print(debugR)
        }
        guard let models = try? JSONDecoder().decode([T].self, from: data) else {
            throw PVPFilmError.localError(message: errorMessage)
        }
        return models
    }
}
