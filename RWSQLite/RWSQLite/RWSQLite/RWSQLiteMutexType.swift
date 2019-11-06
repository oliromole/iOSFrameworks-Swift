//
//  RWSQLiteMutexType.swift
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks-Swift.git
//
//  Created by Roman Oliichuk on 2019.10.17.
//  Copyright (c) 2012-2019 Roman Oliichuk. All rights reserved.
//

/*
 Copyright (C) 2012-2019 Roman Oliichuk. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors
 may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

struct RWSQLiteMutexType: Equatable
{
    public let rawValue: Int
    
    // MARK: Result Codes
    
    public static let fast               = RWSQLiteMutexType( 0) // SQLITE_MUTEX_FAST             0
    public static let recursive          = RWSQLiteMutexType( 1) // SQLITE_MUTEX_RECURSIVE        1
    public static let staticMaster       = RWSQLiteMutexType( 2) // SQLITE_MUTEX_STATIC_MASTER    2
    public static let staticMemory       = RWSQLiteMutexType( 3) // SQLITE_MUTEX_STATIC_MEM       3  /* sqlite3_malloc() */
    public static let staticMemory2      = RWSQLiteMutexType( 4) // SQLITE_MUTEX_STATIC_MEM2      4  /* NOT USED */
    public static let staticOpen         = RWSQLiteMutexType( 4) // SQLITE_MUTEX_STATIC_OPEN      4  /* sqlite3BtreeOpen() */
    public static let staticPRNG         = RWSQLiteMutexType( 5) // SQLITE_MUTEX_STATIC_PRNG      5  /* sqlite3_randomness() */
    public static let staticLRU          = RWSQLiteMutexType( 6) // SQLITE_MUTEX_STATIC_LRU       6  /* lru page list */
    public static let staticLRU2         = RWSQLiteMutexType( 7) // SQLITE_MUTEX_STATIC_LRU2      7  /* NOT USED */
    public static let staticPMEM         = RWSQLiteMutexType( 7) // SQLITE_MUTEX_STATIC_PMEM      7  /* sqlite3PageMalloc() */
    public static let staticApplication1 = RWSQLiteMutexType( 8) // SQLITE_MUTEX_STATIC_APP1      8  /* For use by application */
    public static let staticApplication2 = RWSQLiteMutexType( 9) // SQLITE_MUTEX_STATIC_APP2      9  /* For use by application */
    public static let staticApplication3 = RWSQLiteMutexType(10) // SQLITE_MUTEX_STATIC_APP3     10  /* For use by application */
    public static let staticVfs1         = RWSQLiteMutexType(11) // SQLITE_MUTEX_STATIC_VFS1     11  /* For use by built-in VFS */
    public static let staticVfs2         = RWSQLiteMutexType(12) // SQLITE_MUTEX_STATIC_VFS2     12  /* For use by extension VFS */
    public static let staticVfs3         = RWSQLiteMutexType(13) // SQLITE_MUTEX_STATIC_VFS3     13  /* For use by application VFS */
    
    // MARK: Initializers
    
    public init(_ rawValue: Int)
    {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: Int32)
    {
        self.rawValue = Int(rawValue)
    }
    
    // MARK: Equatable
    
    public static func == (lhs: RWSQLiteMutexType, rhs: RWSQLiteMutexType) -> Bool
    {
        let isEqual: Bool = (lhs.rawValue == rhs.rawValue)
        
        return isEqual
    }
}
