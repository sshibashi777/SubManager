//
//  SubscriptionStore.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/16.
//

import Foundation
import SwiftUI

class SubscribeStore: ObservableObject {
    @Published var subs: [Subscription] = []
    @Published var sub: Subscription = Subscription.sampleData[0]
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("subscriptions.data")
    }
    
    static func load() async throws -> [Subscription] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let subs):
                    continuation.resume(returning: subs)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[Subscription], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let subscriptions = try JSONDecoder().decode([Subscription].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(subscriptions))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(subs: [Subscription]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(subs: subs) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let subsSaved):
                    continuation.resume(returning: subsSaved)
                }
            }
        }
    }
    
    static func save(subs: [Subscription], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(subs)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(subs.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
