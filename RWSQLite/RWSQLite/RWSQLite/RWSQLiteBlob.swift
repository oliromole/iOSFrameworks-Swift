//
//  RWSQLiteBlob.swift
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

class RWSQLiteBlob
{
    private var mSqlite3_blob: OpaquePointer?
    
    // MARK: - Initializers
    
    public init()
    {
        mSqlite3_blob = nil
    }
    
    public convenience init(sqlite3_blob: OpaquePointer?)
    {
        self.init()
        
        self.sqlite3_blob = sqlite3_blob;
    }
    
    // MARK: - Deinitializer
    
    deinit
    {
        if mSqlite3_blob != nil
        {
            let resultCode = RWSQLiteResultCode(sqlite3_blob_close(mSqlite3_blob))
            
            if resultCode != RWSQLiteResultCode.ok
            {
                fatalError("Can not finalize SQLite blob.")
            }
            
            mSqlite3_blob = nil
        }
    }
    
    // MARK: - Managing the sqlite3_blob
    
    public var sqlite3_blob: OpaquePointer?
    {
        get
        {
            return mSqlite3_blob
        }
        set
        {
            if mSqlite3_blob != newValue
            {
                mSqlite3_blob = newValue
            }
        }
    }
    
    // MARK: - Reopening the Blob Object.
    
    public func reopen(rowIdentifier: Int64) throws -> Void
    {
        guard let sqlite3_blob = mSqlite3_blob else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_blob_reopen(sqlite3_blob,
                                                                rowIdentifier))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
    
    // MARK: - Closing the Blob Object
    
    public func cloase() throws -> Void
    {
        guard let sqlite3_blob = mSqlite3_blob else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_blob_close(sqlite3_blob))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
        
        mSqlite3_blob = nil
    }
    
    // MARK: - Testing Data
    
    public func getLength() throws -> Int
    {
        guard let sqlite3_blob = mSqlite3_blob else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let length = Int(sqlite3_blob_bytes(sqlite3_blob))
        
        return length
    }
    
    // MARK: - Reading the Data
    
    public func readData(length: Int, offset: Int) throws -> Data
    {
        guard let sqlite3_blob = mSqlite3_blob else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let byteCArray: UnsafeMutableRawBufferPointer = UnsafeMutableRawBufferPointer.allocate(byteCount: length, alignment: 64)
        
        defer
        {
            byteCArray.deallocate()
        }
        
        let resultCode = RWSQLiteResultCode(sqlite3_blob_read(sqlite3_blob,
                                                              byteCArray.baseAddress,
                                                              Int32(length),
                                                              Int32(offset)))
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
        
        let data: Data
        
        if let byteCArrayBaseAddress: UnsafeMutableRawPointer = byteCArray.baseAddress
        {
            data = Data(bytes: byteCArrayBaseAddress, count: length)
        }
        else
        {
            if length == 0
            {
                data = Data()
            }
            else
            {
                let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
                
                throw error
            }
        }
        
        return data
    }
    
    // MARK: - Writing the Data
    
    public func write(data: Data, offset: Int) throws -> Void
    {
        guard let sqlite3_blob = mSqlite3_blob else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        var resultCode : RWSQLiteResultCode = RWSQLiteResultCode.ok
        
        data.withUnsafeBytes { (byteCArray: UnsafeRawBufferPointer) in
            resultCode = RWSQLiteResultCode(sqlite3_blob_write(sqlite3_blob,
                                                               byteCArray.baseAddress,
                                                               Int32(data.count),
                                                               Int32(offset)))
        }
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
    }
}
