//
//  RWSQLiteFileOpenOptions.swift
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

struct RWSQLiteFileOpenOptions: OptionSet
{
    public let rawValue: Int
    
    // MARK: - Flags for File Open Operations
    
    public static let readonly                                           = RWSQLiteFileOpenOptions(rawValue: 0x00000001) // SQLITE_OPEN_READONLY         0x00000001  /* Ok for sqlite3_open_v2() */
    public static let readWrite                                          = RWSQLiteFileOpenOptions(rawValue: 0x00000002) // SQLITE_OPEN_READWRITE        0x00000002  /* Ok for sqlite3_open_v2() */
    public static let create                                             = RWSQLiteFileOpenOptions(rawValue: 0x00000004) // SQLITE_OPEN_CREATE           0x00000004  /* Ok for sqlite3_open_v2() */
    public static let deleteOnClose                                      = RWSQLiteFileOpenOptions(rawValue: 0x00000008) // SQLITE_OPEN_DELETEONCLOSE    0x00000008  /* VFS only */
    public static let exclusive                                          = RWSQLiteFileOpenOptions(rawValue: 0x00000010) // SQLITE_OPEN_EXCLUSIVE        0x00000010  /* VFS only */
    public static let autoProxy                                          = RWSQLiteFileOpenOptions(rawValue: 0x00000020) // SQLITE_OPEN_AUTOPROXY        0x00000020  /* VFS only */
    public static let uri                                                = RWSQLiteFileOpenOptions(rawValue: 0x00000040) // SQLITE_OPEN_URI              0x00000040  /* Ok for sqlite3_open_v2() */
    public static let memory                                             = RWSQLiteFileOpenOptions(rawValue: 0x00000080) // SQLITE_OPEN_MEMORY           0x00000080  /* Ok for sqlite3_open_v2() */
    public static let mainDatabase                                       = RWSQLiteFileOpenOptions(rawValue: 0x00000100) // SQLITE_OPEN_MAIN_DB          0x00000100  /* VFS only */
    public static let temporaryDatabase                                  = RWSQLiteFileOpenOptions(rawValue: 0x00000200) // SQLITE_OPEN_TEMP_DB          0x00000200  /* VFS only */
    public static let transientDatabase                                  = RWSQLiteFileOpenOptions(rawValue: 0x00000400) // SQLITE_OPEN_TRANSIENT_DB     0x00000400  /* VFS only */
    public static let mainJournal                                        = RWSQLiteFileOpenOptions(rawValue: 0x00000800) // SQLITE_OPEN_MAIN_JOURNAL     0x00000800  /* VFS only */
    public static let journal                                            = RWSQLiteFileOpenOptions(rawValue: 0x00001000) // SQLITE_OPEN_TEMP_JOURNAL     0x00001000  /* VFS only */
    public static let subJournal                                         = RWSQLiteFileOpenOptions(rawValue: 0x00002000) // SQLITE_OPEN_SUBJOURNAL       0x00002000  /* VFS only */
    public static let masterJournal                                      = RWSQLiteFileOpenOptions(rawValue: 0x00004000) // SQLITE_OPEN_MASTER_JOURNAL   0x00004000  /* VFS only */
    public static let noMutex                                            = RWSQLiteFileOpenOptions(rawValue: 0x00008000) // SQLITE_OPEN_NOMUTEX          0x00008000  /* Ok for sqlite3_open_v2() */
    public static let fullMutex                                          = RWSQLiteFileOpenOptions(rawValue: 0x00010000) // SQLITE_OPEN_FULLMUTEX        0x00010000  /* Ok for sqlite3_open_v2() */
    public static let sharedCache                                        = RWSQLiteFileOpenOptions(rawValue: 0x00020000) // SQLITE_OPEN_SHAREDCACHE      0x00020000  /* Ok for sqlite3_open_v2() */
    public static let privateCache                                       = RWSQLiteFileOpenOptions(rawValue: 0x00040000) // SQLITE_OPEN_PRIVATECACHE     0x00040000  /* Ok for sqlite3_open_v2() */
    public static let wal                                                = RWSQLiteFileOpenOptions(rawValue: 0x00080000) // SQLITE_OPEN_WAL              0x00080000  /* VFS only */
    public static let fileProtectionComplete                             = RWSQLiteFileOpenOptions(rawValue: 0x00100000) // SQLITE_OPEN_FILEPROTECTION_COMPLETE                             0x00100000
    public static let fileProtectionCompleteUnlessOpen                   = RWSQLiteFileOpenOptions(rawValue: 0x00200000) // SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN                   0x00200000
    public static let fileProtectionCompleteUntilFirstUserAuthentication = RWSQLiteFileOpenOptions(rawValue: 0x00300000) // SQLITE_OPEN_FILEPROTECTION_COMPLETEUNTILFIRSTUSERAUTHENTICATION 0x00300000
    public static let fileProtectionNone                                 = RWSQLiteFileOpenOptions(rawValue: 0x00400000) // SQLITE_OPEN_FILEPROTECTION_NONE                                 0x00400000
    public static let fileProtectionMask                                 = RWSQLiteFileOpenOptions(rawValue: 0x00700000) // SQLITE_OPEN_FILEPROTECTION_MASK                                 0x00700000
}
