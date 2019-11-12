//
//  RWSQLiteMutex.swift
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

import Foundation
import SQLite3

class RWSQLiteMutex
{
    private var mNeedsFree: Bool
    private var mSqlite3_mutex: OpaquePointer?
    
    // MARK: - Initializers
    
    public init()
    {
        mNeedsFree     = false
        mSqlite3_mutex = nil
    }
    
    public convenience init(mutexType: RWSQLiteMutexType) throws
    {
        guard let sqlite3_mutex: OpaquePointer = sqlite3_mutex_alloc(Int32(mutexType.rawValue)) else {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let needsFree : Bool = ((mutexType != RWSQLiteMutexType.fast) &&
                                (mutexType != RWSQLiteMutexType.recursive))
        
        
        self.init(sqlite3_mutex: sqlite3_mutex, needsFree: needsFree)
    }
    
    public convenience init(sqlite3_mutex: OpaquePointer?, needsFree: Bool)
    {
        self.init()
        
        self.set(sqlite3_mutex: sqlite3_mutex, needsFree: needsFree)
    }
    
    // MARK: - Deinitializer
    
    deinit
    {
        if (mSqlite3_mutex != nil) && mNeedsFree
        {
            sqlite3_mutex_free(mSqlite3_mutex)
            mSqlite3_mutex = nil;
        }
    }
    
    // MARK: - Managing the sqlite3_stmt
    
    public var needsFree: Bool
    {
        get
        {
            return mNeedsFree
        }
    }
    
    public var sqlite3_mutex: OpaquePointer?
    {
        get
        {
            return mSqlite3_mutex
        }
    }
    
    public func set(sqlite3_mutex: OpaquePointer?, needsFree: Bool) -> Void
    {
        mNeedsFree     = needsFree
        mSqlite3_mutex = sqlite3_mutex
    }
    
    // MARK: - Entering and Trying and Leaving the Mutex
    
    public func enter() throws -> Void
    {
        guard let sqlite3_mutex = mSqlite3_mutex else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        sqlite3_mutex_enter(sqlite3_mutex)
    }
    
    public func `try`() throws -> Bool
    {
        guard let sqlite3_mutex = mSqlite3_mutex else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_mutex_try(sqlite3_mutex))
        
        let entered: Bool = (resultCode == RWSQLiteResultCode.ok)
        
        return entered
    }
    
    public func leave() throws -> Void
    {
        guard let sqlite3_mutex = mSqlite3_mutex else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        sqlite3_mutex_leave(sqlite3_mutex)
    }
}
