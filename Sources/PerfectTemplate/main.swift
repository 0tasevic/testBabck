//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectHTTP
import PerfectHTTPServer
 

var broj = 0

// Register your own routes and handlers
var routes = Routes()
routes.add(method: .get, uri: "/") {
    request, response in
    response.setHeader(.contentType, value: "application/json")
    let jsonResponse: [String: Any] = ["Alive": true , "Broj": broj]
    
    broj = 0
    
    do{
        try response.setBody(json: jsonResponse)
    }catch{
        //...
    }
    response.completed()
    
}



routes.add(method: .post, uri: "/add") { request, response in
    
     response.setHeader(.contentType, value: "application/json")
       var responsePayload : [String: Any] = ["sum": 0]
       
    if let operandOne = request.param(name: "operandOne"),let operandTwo = request.param(name: "operandTwo"){
        if let lhs = Int(operandOne), let rhs = Int(operandTwo){
            responsePayload["sum"] = lhs + rhs
            print(responsePayload["sum"])
        }
    }

    
       do{
           try response.setBody(json: responsePayload)
       }catch{
           //...
       }
       response.completed()
}


routes.add(method: .post, uri: "/a") {
    request, response in
    
     response.setHeader(.contentType, value: "application/json")
       var responsePayload : [String: Any] = ["sum": 0]
       
    if let operandOne = request.param(name: "operandOne"){
        if let lhs = Int(operandOne){
             broj += lhs
            responsePayload["sum"] = broj
        }
    }

    
       do{
           try response.setBody(json: responsePayload)
       }catch{
           //...
       }
       response.completed()
}
 
do {
    // Launch the HTTP server.
    try HTTPServer.launch(
        .server(name: "localhost", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}
