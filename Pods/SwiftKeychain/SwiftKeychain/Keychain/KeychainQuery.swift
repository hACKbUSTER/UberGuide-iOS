//
//  KeychainQuery.swift
//  SwiftKeychain
//
//  Created by Yanko Dimitrov on 11/13/14.
//  Copyright (c) 2014 Yanko Dimitrov. All rights reserved.
//

import Foundation

public class KeychainQuery {
    
    private lazy var queryFields = NSMutableDictionary()
    
    public var fields: NSDictionary {
        
        return queryFields
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - Initializers
    ///////////////////////////////////////////////////////
    
    public init(keychain: KeychainService) {
        
        addField(kSecAttrAccessible, withValue: keychain.accessMode)
        
        if let accessGroup = keychain.accessGroup {
            
            addField(kSecAttrAccessGroup, withValue: accessGroup)
        }
    }
    
    ///////////////////////////////////////////////////////
    // MARK: - Methods
    ///////////////////////////////////////////////////////
    
    public func shouldReturnData() {
        
        addField(kSecReturnData, withValue: true)
    }
    
    public func addField(field: NSString, withValue value: AnyObject) {
        
        queryFields.setObject(value, forKey: field)
    }
    
    public func addFields(fields: [NSObject: AnyObject]) {
        
        queryFields.addEntriesFromDictionary(fields)
    }
}
