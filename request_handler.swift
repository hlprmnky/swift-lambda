/*
 compiled using:
  Swift version 3.0 (swift-3.0-PREVIEW-3)
  Target: x86_64-unknown-linux-gnu
 */
#if os(OSX) || os(iOS)
  import Darwin
#elseif os(Linux)
  import Glibc
#endif

import Foundation

let stdin = FileHandle.fileHandleWithStandardInput()
let stdout = FileHandle.fileHandleWithStandardOutput()
let stderr = FileHandle.fileHandleWithStandardError()

do
{
  // read JSON input ( String -> Dictionary )
  guard let inputDict = try JSONSerialization.jsonObject( with: stdin.availableData ) as? [ String: Any ] else
  {
    stderr.write( "Expected JSON object, but got something else (array, primitive, etc.)\n".data( using: .utf8 )! )
    exit( -2 )
  }
  let idType = inputDict[ "idType" ] as? String ?? "uuid"
  let id = inputDict[ "id" ] as? String ?? NSUUID().UUIDString
  let outputDict = [ "idType": idType, "id": id ] 
  do
  {
    // write JSON output ( Dictionary -> String )
    let dataOut = try JSONSerialization.data( withJSONObject: outputDict.bridge() )
    stdout.write( dataOut )
  }
  catch let jsonMarshallingError
  {
    stderr.write( "JSON Marshalling Error: \(jsonMarshallingError)".data( using: .utf8 )! )
    exit( -3 )
  }
  stdout.write( id.data( using: .utf8 )! )
  exit( 0 )
}
catch let jsonParsingError
{
  stderr.write( "JSON Error: \(jsonParsingError)".data( using: .utf8 )! )
  exit( -1 )
}
