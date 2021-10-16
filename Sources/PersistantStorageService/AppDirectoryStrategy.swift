//
//  AppDirectoryStrategy.swift
//  AppDirectoryStrategy
//
//  Created by Labtanza on 9/11/21.
//

import Foundation

extension PersistantStorageService {
    
    struct AppDirectoryStrategy:StorageStrategy {
        
        var fileName:String
        var fileType:String
        
        var url:URL {
            LocalURLBuilder.documentDirectoryURL(resourceName: fileName, type: fileType)
        }
        
        var locationDescription: String {
            "Local Storage:\(url)"
        }
        
        var localStorage: PersistantStorageService.LocalStrategy {
            PersistantStorageService.LocalStrategy(localURL:url)
        }
        
        func load() throws -> [Item]?  {
           
            guard let data = try? localStorage.loadData() else {
                throw PersistantStorageError.storageLocationNonResponsive
            }
            
            guard let items = try? PersistantStorageService.parseJSON(data) else {
                throw PersistantStorageError.resourceDidNotContainDecodeableItems
            }
            
            return items
        }
        
        func cleanSave(_ items:[Item]) throws {

            guard let data = try? PersistantStorageService.packageJSON(items) else {
                print("Could not package JSON")
                throw PersistantStorageError.couldNotEncode
            }
            localStorage.write(data)
            
        }
        
        func clear() throws {
            localStorage.write("")
        }
        
        func append(_ items:[Item]) throws -> [Item] {
            var itemsToSave:[Item] = []
            
            if let oldItems = try load() {
                itemsToSave.append(contentsOf: oldItems)
            }
            
            itemsToSave.append(contentsOf: items)
            
            guard let newData = try? PersistantStorageService.packageJSON(itemsToSave) else {
                print("Could not package JSON")
                throw PersistantStorageError.couldNotEncode
            }
            
            localStorage.write(newData)
            return itemsToSave
        }
    }
    
}


