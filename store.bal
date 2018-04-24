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

    var ret = testDB -> update("CREATE TABLE PRODUCTS(ID INT ,NAME VARCHAR(255), COUNT INT,PRIMARY KEY (ID))");
    sql:Parameter p1 = (sql:TYPE_INTEGER, 1, sql:DIRECTION_IN);
    sql:Parameter p2 = (sql:TYPE_VARCHAR, "APIM", sql:DIRECTION_IN);
    sql:Parameter p3 = (sql:TYPE_INTEGER, 10, sql:DIRECTION_IN);
    var insertVal1 = testDB -> update("INSERT INTO PRODUCTS (ID,NAME,COUNT) VALUES (?, ?, ?)",p1, p2, p3);
    match ret {
    int status => {
           io:println("Insert status:" + status);
    }
    error err => {
           io:println("Error Message: "+err.message);
    }
    }

    sql:Parameter p4 = (sql:TYPE_INTEGER, 2, sql:DIRECTION_IN);
    sql:Parameter p5 = (sql:TYPE_VARCHAR, "IS", sql:DIRECTION_IN);
    sql:Parameter p6 = (sql:TYPE_INTEGER, 20, sql:DIRECTION_IN);
    var insertVal2 = testDB -> update("INSERT INTO PRODUCTS (ID,NAME,COUNT) VALUES (?, ?, ?)", p4,p5,p6);
   	match ret {
        int status => {
            io:println("Insert status:" + status);
        }
        error err => {
	   io:println("Error Message: "+err.message);
	}
    }
	http:Response res = new;
        res.setPayload("Data Added");
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
    json j = check <json>dt;
    jsonRes = j.toString();
    http:Response res = new;
    res.setPayload(jsonRes);
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
            io:println("Update status:" + status);
        }
        error err => {
	io:println(err.message);
         }
    }
 	var dtReturned = testDB -> select("SELECT * FROM PRODUCTS", null);
	dt = check dtReturned;      
 	string jsonRes;
    	json j = check <json>dt;
    	jsonRes = j.toString();
        http:Response res = new;
        res.setPayload(jsonRes);
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
            io:println("Update status:" + status);
        }
        error err => {
	io:println(err.message);
         }
    }
 	var dtReturned = testDB -> select("SELECT * FROM PRODUCTS", null);
	dt = check dtReturned;      
 	string jsonRes;
    	json j = check <json>dt;
    	jsonRes = j.toString();
        http:Response res = new;
        res.setPayload(jsonRes);
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
        res.setPayload("Data Deleted");
        _ = outboundEP -> respond(res);
     }
}

