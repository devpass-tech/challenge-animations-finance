//
//  FinanceService.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import Foundation

protocol FinanceServiceProtocol: AnyObject {
    func fetchHomeData()
    func fetchSplash(for file: LocalResponse, completion: FinanceService.FetchSplashCompletionBlock)
}

final class FinanceService: FinanceServiceProtocol {
    
    //MARK: - Alias
    typealias FetchSplashCompletionBlock = ((Result<RemoteSplashResponse, LocalError>) -> Void)
    
    //MARK: - Properties
    private let decoder: DecoderProvider
    
    //MARK: - Initializers
    init(decoderProvider: DecoderProvider = JSONDecoder()) {
        decoder = decoderProvider
    }
    
    //MARK: - FinanceServiceProtocol
    func fetchSplash(for file: LocalResponse, completion: FetchSplashCompletionBlock) {
        guard let path = file.path else { return completion(.failure(.notFound)) }
        
        guard let data = try? Data(contentsOf: path) else {
            return completion(.failure(.dataConvertion))
        }
        
        guard let reponse = decoder.decodeObject(RemoteSplashResponse.self, from: data) else {
            return completion(.failure(.decode))
        }
        
        completion(.success(reponse))
    }
    
    func fetchHomeData() {
        
    }
}
