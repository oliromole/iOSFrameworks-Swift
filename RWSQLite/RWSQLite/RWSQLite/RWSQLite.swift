//
//  RWSQLite.swift
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

class RWSQLite
{
    private var mSqlite3: OpaquePointer?
    
    // MARK: Initializers
    
    public init()
    {
        mSqlite3 = nil
    }
    
    public convenience init(sqlite3: OpaquePointer?)
    {
        self.init()
        
        self.sqlite3 = sqlite3;
    }
    
    public convenience init(fileName: String?, fileOpenOptions: RWSQLiteFileOpenOptions, virtualFileSystem: String?) throws
    {
        var sqlite3: OpaquePointer?
        
        let resultCode = RWSQLiteResultCode(sqlite3_open_v2(fileName,
                                                            &sqlite3,
                                                            Int32(fileOpenOptions.rawValue),
                                                            virtualFileSystem))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: resultCode)

            throw error
        }
        
        self.init(sqlite3: sqlite3)
    }
    
    public convenience init(url: URL?, fileOpenOptions: RWSQLiteFileOpenOptions, virtualFileSystem: String?) throws
    {
        var sqlite3: OpaquePointer?
        
        let urlOpenOptions2: RWSQLiteFileOpenOptions = [fileOpenOptions, RWSQLiteFileOpenOptions.uri]
        
        let resultCode = RWSQLiteResultCode(sqlite3_open_v2(url?.absoluteString,
                                                            &sqlite3,
                                                            Int32(urlOpenOptions2.rawValue),
                                                            virtualFileSystem))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: resultCode)
            
            throw error
        }
        
        self.init(sqlite3: sqlite3)
    }
    
    // MARK: Deinitializer
    
    deinit
    {
        if mSqlite3 != nil
        {
            let resultCode = RWSQLiteResultCode(sqlite3_close(mSqlite3))
            
            if resultCode != RWSQLiteResultCode.ok
            {
                fatalError("Can not close SQLite database.")
            }
            
            mSqlite3 = nil;
        }
    }
    
    // MARK: - Managing the sqlite3
    
    public var sqlite3: OpaquePointer?
    {
        get
        {
            return mSqlite3
        }
        set
        {
            if mSqlite3 != newValue
            {
                mSqlite3 = newValue
            }
        }
    }
}
