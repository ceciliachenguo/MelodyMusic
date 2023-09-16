//
//  CodeRequest.swift
//  request verification parameters model
//
//  Created by Cecilia Chen on 9/16/23.
//

class CodeRequest: BaseModel {
    var phone:String!
    var email:String!
    
    // if send verification code too frequent, pass image verification
    var code:String!
}
