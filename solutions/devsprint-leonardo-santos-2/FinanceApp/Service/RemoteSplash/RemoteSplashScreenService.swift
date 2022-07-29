//
//  RemoteSplashScreenService.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 29/07/22.
//

import Foundation

protocol RemoteSplashScreenServiceProtocol {
    func fetch(
        for file: DevpassLocalResponse,
        completion: RemoteSplashScreenService.RSRCompletionBlock
    )
}

final class RemoteSplashScreenService: RemoteSplashScreenServiceProtocol {
    
    //MARK: - Alias
    typealias Response = RemoteSplashResponse.Response
    typealias RSRCompletionBlock = ((Result<Response, LocalError>) -> Void)
    
    //MARK: - Properties
    private let decoder: DecoderProvider
    
    //MARK: - Initializers
    init(decoderProvider: DecoderProvider = JSONDecoder()) {
        decoder = decoderProvider
    }
    
    //MARK: -
    func fetch(for file: DevpassLocalResponse, completion: RSRCompletionBlock) {
        guard let path = file.path else { return completion(.failure(.notFound)) }
        
        guard let data = try? Data(contentsOf: path) else {
            return completion(.failure(.dataConvertion))
        }
        
        guard let reponse = decoder.performDecode(Response.self, from: data) else {
            return completion(.failure(.decode))
        }
        
        completion(.success(reponse))
    }
}
