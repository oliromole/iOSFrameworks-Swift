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
    
    // MARK: - Initializers
    
    public init()
    {
        mSqlite3 = nil
    }
    
    public convenience init(sqlite3: OpaquePointer?)
    {
        self.init()
        
        self.sqlite3 = sqlite3;
    }
    
    public convenience init(fileName: String, fileOpenOptions: RWSQLiteFileOpenOptions, virtualFileSystem: String?) throws
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
        let urlOpenOptions2: RWSQLiteFileOpenOptions = [fileOpenOptions, RWSQLiteFileOpenOptions.uri]
        
        var sqlite3: OpaquePointer?
        
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
    
    // MARK: - Deinitializer
    
    deinit
    {
        if mSqlite3 != nil
        {
            let resultCode : RWSQLiteResultCode

            if #available(iOS 8.2, *)
            {
                resultCode = RWSQLiteResultCode(sqlite3_close_v2(sqlite3))
            }
            else
            {
                resultCode = RWSQLiteResultCode(sqlite3_close(sqlite3))
            }
            
            if resultCode != RWSQLiteResultCode.ok
            {
                fatalError("Can not close SQLite database.")
            }
            
            mSqlite3 = nil;
        }
    }
    
    // MARK: - Configuring The SQLite Library
    
    public func threadsafeMode() -> RWSQLiteLibraryThreadsafeMode
    {
        let threadsafeMode = RWSQLiteLibraryThreadsafeMode(sqlite3_threadsafe())
        
        return threadsafeMode
    }
    
    //
    // NOTE: Use the parameter "fileOpenOptions" (RWSQLiteFileOpenOptions.noMutex or RWSQLiteFileOpenOptions.fullMutex) in the method "init", becasee the 'sqlite3_config' is unavailable for Swift (variadic function is unavailable).
    //
    //public func setThreadsafeMode(_ threadsafeMode: RWSQLiteLibraryThreadsafeMode) throws -> Void
    //
    
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
    
    // MARK: - Closing A Database Connection
    
    public func close(automatic: Bool = true) throws -> Void
    {
        guard let sqlite3 = mSqlite3 else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let resultCode : RWSQLiteResultCode
        
        if automatic
        {
            if #available(iOS 8.2, *)
            {
                resultCode = RWSQLiteResultCode(sqlite3_close_v2(sqlite3))
            }
            else
            {
                resultCode = RWSQLiteResultCode(sqlite3_close(sqlite3))
            }
        }
        else
        {
            resultCode = RWSQLiteResultCode(sqlite3_close(sqlite3))
        }
        
        if (resultCode != RWSQLiteResultCode.ok)
        {
            let error = RWSQLiteErrorCreate(sqlite3:sqlite3, resultCodeOrExtendedResultCode: resultCode)
            
            throw error
        }
        
        mSqlite3 = nil
    }
    
    // MARK: - Getting the Last Error
    
    public func lastError() -> RWSQLiteError
    {
        let error: RWSQLiteError = RWSQLiteErrorCreate(sqlite3: mSqlite3)
        
        return error;
    }
    
    public func throwLastError() throws -> Void
    {
        let error: RWSQLiteError = RWSQLiteErrorCreate(sqlite3: mSqlite3)
        
        throw error
    }
    
    // MARK: - Getting the Last Insert Rowid
    
    public func lastInsertRowIdentifier() -> Int64
    {
        var lastInsertRow:Int64 = 0
        
        if (mSqlite3 != nil)
        {
            lastInsertRow = Int64(sqlite3_last_insert_rowid(mSqlite3))
        }
        
        return lastInsertRow
    }
    
    // MARK: - Getting the Number of Rows Changed
    
    public func numberOfChangedRows() -> Int
    {
        var numberOfChangedRows: Int = 0
        
        if (mSqlite3 != nil)
        {
            numberOfChangedRows = Int(sqlite3_changes(mSqlite3))
        }
        
        return numberOfChangedRows
    }
    
    // MARK: - Getting the Total of Rows Changed
    
    public func totalOfChangedRows() -> Int
    {
        var totalOfChangedRows: Int = 0
        
        if (mSqlite3 != nil)
        {
            totalOfChangedRows = Int(sqlite3_total_changes(mSqlite3))
        }
        
        return totalOfChangedRows
    }
    
    // MARK: - Interrupting A Long-Running Query
    
    public func interrupt() -> Void
    {
        if (mSqlite3 != nil)
        {
            sqlite3_interrupt(mSqlite3)
        }
    }
    
    // MARK: - Creating the Statement
    
    public func createStatement(command: String) throws -> RWSQLiteStatement
    {
        guard let sqlite3 = mSqlite3 else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        var sqlite3_stmt: OpaquePointer?
        
        let resultCode = RWSQLiteResultCode(sqlite3_prepare_v2(sqlite3,
                                                               command,
                                                               -1,
                                                               &sqlite3_stmt,
                                                               nil));
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
        
        let statement = RWSQLiteStatement(sqlite3_stmt: sqlite3_stmt)
        
        return statement
    }
    
    // MARK: - Retrieving the Mutex for the Database Connection
    
    public func createMutex() throws -> RWSQLiteMutex
    {
        guard let sqlite3 = mSqlite3 else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        guard let sqlite3_mutex: OpaquePointer = sqlite3_db_mutex(sqlite3) else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        let mutex = RWSQLiteMutex(sqlite3_mutex: sqlite3_mutex, needsFree: false)
        
        return mutex
    }
    
    // MARK: - Opening the Blob
    
    public func openBlob(databaseName: String, tableName: String, columnName: String, rowIdentifier: Int64, options:RWSQLiteBlobOpenOptions) throws -> RWSQLiteBlob
    {
        guard let sqlite3 = mSqlite3 else
        {
            let error = RWSQLiteErrorCreate(resultCodeOrExtendedResultCode: RWSQLiteResultCode.error)
            
            throw error
        }
        
        var sqlite3_blob: OpaquePointer?
        
        let resultCode = RWSQLiteResultCode(sqlite3_blob_open(sqlite3,
                                                              databaseName,
                                                              tableName,
                                                              columnName,
                                                              rowIdentifier,
                                                              Int32(options.rawValue),
                                                              &sqlite3_blob));
        
        if resultCode != RWSQLiteResultCode.ok
        {
            let error = RWSQLiteErrorCreate(sqlite3: sqlite3, resultCodeOrExtendedResultCode: resultCode);
            
            throw error
        }
        
        let blob = RWSQLiteBlob(sqlite3_blob: sqlite3_blob)
        
        return blob
    }
}
