//
//  NetworkError.swift
//  WinePair
//
//  Created by Matheus Góes on 01/10/22.
//

import Foundation

enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameters encoding failed."
    case missingURL = "URL is nil."
}
