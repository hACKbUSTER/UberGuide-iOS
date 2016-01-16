#SwiftKeychain
An elegant Swift wrapper around the Apple Keychain API, made for iOS. Take a look at the class diagram to find out how the SwiftKeychain will fit inside your project *(Figure 1)*:

![SwiftKeychain UML class diagram](https://raw.githubusercontent.com/yankodimitrov/SwiftKeychain/master/class-diagram.jpg "Figure 1. SwiftKeychain UML class diagram")

*Figure 1: SwiftKeychain UML class diagram*

## Update
Apparently the Swift compiler don’t like the *KeychainItem* protocol as a generic method type constraint. To fix the issue I introduced a concrete implementation of that protocol in the form of *BaseKey* class and use it for the type constraint in the generic method instead. The *BaseKey* class is also used as a base class for the *GenericKey* and *ArchiveKey* classes.

##Installation

#### CocoaPods
Add the pod <code>SwiftKeychain</code> to your <code>Podfile</code>:

<code>pod “SwiftKeychain”</code>

#### Manually
- Add the <code>Security.framework</code> to your target
- Copy the contents of the <code>SwiftKeychain/Keychain</code> folder to your project:
    - <code>KeychainService.swift</code>
    - <code>KeychainItem.swift</code>
    - <code>KeychainQuery.swift</code>
    - <code>Keychain.swift</code>
    - <code>GenericKey.swift</code>
    - <code>ArchiveKey.swift</code>

##Usage
You can create an instance of the <code>Keychain</code> class or you can use the Singleton instance by accessing the <code>sharedKeychain</code> class property.

The default Keychain items access mode is set to <code>kSecAttrAccessibleWhenUnlocked</code>, but you can change that by passing the appropirate value in the <code>Keychain</code> designated initializer.

The <code>Keychain</code> class works with objects conforming to <code>KeychainItem</code> protocol. There are two concrete implementations included, that will cover most of the use case scenarios: <code>GenericKey</code> and <code>ArchiveKey</code>. Of course you can always drop in your own, just conform to the <code>KeychainItem</code> protocol.

####GenericKey
Use an instance of the <code>GenericKey</code> class to store, obtain, update or delete a string value in/from the Keychain.

####ArchiveKey
Use the <code>ArchiveKey</code> class to store, obtain, update or delete an object that conforms to <code>NSCoding</code> protocol in/from the Keychain. 

###Adding an item

#####GenericKey
```swift
let passcodeKey = GenericKey(keyName: "passcode", value: "1234")
let keychain = Keychain()

if let error = keychain.add(passcodeKey) {
    
    // handle the error
}

```

#####ArchiveKey
```swift
let user = ["name": "Mike", "age": 30]

let userKey = ArchiveKey(keyName: "user", object: user)
let keychain = Keychain()

if let error = keychain.add(userKey) {
    
    // handle the error
}

```

###Updating an item

```swift
let passcodeKey = GenericKey(keyName: "passcode", value: "5678")
let keychain = Keychain()

if let error = keychain.update(passcodeKey) {
    
    // handle the error
}
```

###Removing an item

```swift
let passcodeKey = GenericKey(keyName: "passcode")
let keychain = Keychain()

if let error = keychain.remove(passcodeKey) {
    
    // handle the error
}
```

###Obtaining an item

#####GenericKey
```swift
let passcodeKey = GenericKey(keyName: "passcode")
let keychain = Keychain()

if let passcode = keychain.get(passcodeKey).item?.value {
    
    println("passcode is: \(passcode)")
}
```

#####ArchiveKey
```swift
// assuming that we have saved the following dictionary in the Keychain:
// let user = ["name": "Mike", "age": 30]

let userKey = ArchiveKey(keyName: "user")
let keychain = Keychain()

if let user = keychain.get(userKey).item?.object as? NSDictionary {
        
    let name = user["name"] as String
    let age = user["age"] as Int
    
    println("name: \(name), age: \(age)")
}

```

##Tests?
Yes, you can find them in the <code>SwiftKeychainTests</code> folder.

##License
SwiftKeychain is released under the MIT license. See the LICENSE.txt file for more info.