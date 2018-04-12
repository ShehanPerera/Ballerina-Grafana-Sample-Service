import ballerina/http;
import ballerina/sql;
import ballerina/io;
import ballerina/mysql;

endpoint mysql:Client testDB {
    host:"localhost",
    port:3306,
    name:"testdb",
    username:"root",
    password:"root",
    poolOptions:{maximumPoolSize:5}
};

endpoint http:Listener storeEP {
    port:9092
};


@Description {value:"Sample sql insert  service."}
service<http:Service> adddata bind storeEP {

    @Description {value:"The storeResource only accepts requests made using the specified HTTP methods"}
    @http:ResourceConfig {
        methods:["POST", "PUT", "GET"],
        path:"/"
    }
    storeResource (endpoint outboundEP, http:Request req) {
	
    var ret = testDB -> update("CREATE TABLE PRODUCTS(ID INT AUTO_INCREMENT,NAME VARCHAR(255), COUNT INT,PRIMARY KEY (ID))");
    sql:Parameter p1 = {sqlType:sql:TYPE_INTEGER, value:1};
    sql:Parameter p2 = {sqlType:sql:TYPE_VARCHAR, value:"APIM"};
    sql:Parameter p3 = {sqlType:sql:TYPE_INTEGER, value:10};
   
    sql:Parameter[] item1 = [p1, p2,p3];
    sql:Parameter p4 = {sqlType:sql:TYPE_INTEGER, value:2};
    sql:Parameter p5 = {sqlType:sql:TYPE_VARCHAR, value:"IS"};
    sql:Parameter p6 = {sqlType:sql:TYPE_INTEGER, value:20};
   
    sql:Parameter[] item2 = [p4, p5,p6];
    sql:Parameter[][] bPara = [item1, item2];
    var insertVal = testDB -> batchUpdate("INSERT INTO PRODUCTS (ID,NAME,COUNT) VALUES (?, ?, ?)", bPara);
   	match ret {
        int status => {
            io:println("Table creation status:" + status);
        }
        error err => {
	   io:println("Error Message: "+err.message);
	}
    }
	http:Response res = new;
        res.setStringPayload("Data Added");
        _ = outboundEP -> respond(res);
     }
}

@Description {value:"Sample store service."}
service<http:Service> store bind storeEP {

    @Description {value:"The storeResource only accepts requests made using the specified HTTP methods"}
    @http:ResourceConfig {
        methods:["POST", "PUT", "GET"],
        path:"/"
    }
    storeResource (endpoint outboundEP, http:Request req) {
	
    var dtReturned = testDB -> select("SELECT * FROM PRODUCTS", null);
    table dt = check dtReturned;
    string jsonRes;
    var j = check <json>dt;
    jsonRes = j.toString() but {() => ""};
    http:Response res = new;
    res.setStringPayload(jsonRes);
     _ = outboundEP -> respond(res);
    }
}

@Description {value:"Sample store service."}
service<http:Service> buyone bind storeEP {

    @Description {value:"The storeResource only accepts requests made using the specified HTTP methods"}
    @http:ResourceConfig {
        methods:["POST", "PUT", "GET"],
        path:"/"
    }
    storeResource (endpoint outboundEP, http:Request req) {
	table dt;
	var ret = testDB -> update("UPDATE PRODUCTS SET COUNT= COUNT -1 WHERE ID = 1 OR ID = 2");
    	match ret {
        int status => {
            io:println("Action status:" + status);
        }
        error err => {
	io:println(err.message);
         }
    }
 	var dtReturned = testDB -> select("SELECT * FROM PRODUCTS", null);
	dt = check dtReturned;      
 	string jsonRes;
    	var j = check <json>dt;
    	jsonRes = j.toString() but {() => ""};
        http:Response res = new;
        res.setStringPayload(jsonRes);
        _ = outboundEP -> respond(res);
    }
}

service<http:Service> addone bind storeEP {

    @Description {value:"The helloResource only accepts requests made using the specified HTTP methods"}
    @http:ResourceConfig {
        methods:["POST", "PUT", "GET"],
        path:"/"
    }
    storeResource (endpoint outboundEP, http:Request req) {
	table dt;
	var ret = testDB -> update("UPDATE PRODUCTS SET COUNT= COUNT +1 WHERE ID = 1 OR ID = 2");
    match ret {
        int status => {
            io:println("Action status:" + status);
        }
        error err => {
	io:println(err.message);
         }
    }
 	var dtReturned = testDB -> select("SELECT * FROM PRODUCTS", null);
	dt = check dtReturned;      
 	string jsonRes;
    	var j = check <json>dt;
    	jsonRes = j.toString() but {() => ""};
        http:Response res = new;
        res.setStringPayload(jsonRes);
        _ = outboundEP -> respond(res);
    }
}
@Description {value:"Sample sql insert  service."}
service<http:Service> deletedata bind storeEP {

    @Description {value:"The storeResource only accepts requests made using the specified HTTP methods"}
    @http:ResourceConfig {
        methods:["POST", "PUT", "GET"],
        path:"/"
    }
    storeResource (endpoint outboundEP, http:Request req) {
	
     var ret = testDB -> update("DROP TABLE PRODUCTS");
    match ret {
        int status => {
            io:println("Table drop status:" + status);
        }
        error err => {
            io:println(err.message);
       }
    }
	http:Response res = new;
        res.setStringPayload("Data Deleted");
        _ = outboundEP -> respond(res);
     }
}

