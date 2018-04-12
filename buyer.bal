import ballerina/http;
import ballerina/sql;
import ballerina/io;

endpoint http:Listener buyerEP {
    port:9091
};

endpoint http:SimpleClient showallEP {
    url:"http://localhost:9092/store"
};

endpoint http:SimpleClient buyoneEP {
    url:"http://localhost:9092/buyone"
};

@Description {value:"Sample service for view all data."}
service<http:Service> showall bind buyerEP {

    @Description {value:"The passthrough resource allows all HTTP methods since the resource configuration does not explicitly specify which HTTP methods are allowed."}
    @http:ResourceConfig {
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request req) {
        // Calling forward() on the backend client endpoint forwards the request the passthrough resource received to the backend.
        // When forwarding, the request is made using the same HTTP method used to invoke the passthrough resource.
        // The forward() function returns the response from the backend if there weren't any errors.
        var clientResponse = showallEP -> forward("/", req);



        // Since forward() can return an error as well, a matcher is required to handle the two cases.
        match clientResponse {
            http:Response res => {
                // If the request was successful, an HTTP response will be returned.
                // Here, the received response is forwarded to the client through the outbound endpoint.
                _ = outboundEP -> respond(res);
            }
            http:HttpConnectorError err => {
                // If there was an error, it is used to construct a 500 response and this is sent back to the client.
                http:Response res = new;
                res.statusCode = 500;
                res.setStringPayload(err.message);
                _ = outboundEP -> respond(res);
            }
        }
    }
	
}

@Description {value:"Sample service for remove all items by one as a buyer."}
service<http:Service> buyone bind buyerEP {

    @Description {value:"The passthrough resource allows all HTTP methods since the resource configuration does not explicitly specify which HTTP methods are allowed."}
    @http:ResourceConfig {
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request req) {
        // Calling forward() on the backend client endpoint forwards the request the passthrough resource received to the backend.
        // When forwarding, the request is made using the same HTTP method used to invoke the passthrough resource.
        // The forward() function returns the response from the backend if there weren't any errors.
        var clientResponse = buyoneEP -> forward("/", req);

        // Since forward() can return an error as well, a matcher is required to handle the two cases.
        match clientResponse {
            http:Response res => {
                // If the request was successful, an HTTP response will be returned.
                // Here, the received response is forwarded to the client through the outbound endpoint.
                _ = outboundEP -> respond(res);
            }
            http:HttpConnectorError err => {
                // If there was an error, it is used to construct a 500 response and this is sent back to the client.
                http:Response res = new;
                res.statusCode = 500;
                res.setStringPayload(err.message);
                _ = outboundEP -> respond(res);
            }
        }
    }
   	
}



