//
//  Error.swift
//  MakeTargetType
//
//  Created by Gab on 2/3/26.
//

import Foundation

enum ValidateError: Error {
    case missing(Missing)
    case create(Create)

    enum Missing: Error {
        case projectURL
        case displayName
    }
    
    enum Create: Error {
        case folder(String)
    }
}

extension ValidateError {
    var alert: AlertModel {
        switch self {
        case .missing(let missingError):
            switch missingError {
            case .projectURL:
                AlertModel(
                    title: "에러",
                    message: "프로젝트 경로가 설정되지 않았습니다."
                )
            case .displayName:
                AlertModel(
                    title: "에러",
                    message: "Display Name(모델 네이밍)을 입력해주세요."
                )
            }
        case .create(let createError):
            switch createError {
            case .folder(let description):
                AlertModel(
                    title: "에러",
                    message: "폴더 생성 실패 : \(description)"
                )
            }
        }
    }
}

extension ValidateError.Missing: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .projectURL:
            return "projectURL 미 설정 에러"
        case .displayName:
            return "displayName 미 입력 에러"
        }
    }
}
