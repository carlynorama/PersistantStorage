//
//  StorageStrategy.swift
//  StorageStrategy
//
//  Created by Labtanza on 9/11/21.
//

import Foundation



protocol StorageStrategy {
    associatedtype Item:ASCIIPersistable
    
    var locationDescription:String { get }
    
    func load() throws -> [Item]?
    func cleanSave(_: [Item]) throws
    func append(_: [Item]) throws -> [Item]
    func clear() throws
    //updateRecord
    //newRecord
}



//enum DataStorageStrategy:StorageStrategy {
//    typealias Item 
//    
//    //case userDefaults
//    //case remoteURL
//    case appDirectory
//    //case coreData
//    //case coreDataCloud
//    //case documentBased
//    //case multiSourceSynced
//}
//
//extension DataStorageStrategy {
//    
