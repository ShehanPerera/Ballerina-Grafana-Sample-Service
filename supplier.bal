import ballerina/http;
import ballerina/sql;
import ballerina/io;

endpoint http:ServiceEndpoint supplyerEP {
    port:9093
};

endpoint http:SimpleClientEndpoint storeEP {
    url:"http://localhost:9092/store"
};
endpoint http:SimpleClientEndpoint addEP {
    url:"http://localhost:9092/addone"
};
endpoint http:SimpleClientEndpoint adddataEP {
    url:"http://localhost:9092/adddata"
};
endpoint http:SimpleClientEndpoint deletedataEP {
    url:"http://localhost:9092/deletedata"
};


@Description {value:"Sample service for view all data."}
service<http:Service> store bind supplyerEP {

    @Description {value:"The passthrough resource allows all HTTP methods since the resource configuration does not explicitly specify which HTTP methods are allowed."}
    @http:ResourceConfig {
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request req) {
        // Calling forward() on the backend client endpoint forwards the request the passthrough resource received to the backend.
        // When forwarding, the request is made using the same HTTP method used to invoke the passthrough resource.
        // The forward() function returns the response from the backend if there weren't any errors.
        var clientResponse = storeEP -> forward("/", req);

        // Since forward() can return an error as well, a matcher is required to handle the two cases.
        match clientResponse {
            http:Response res => {
                // If the request was successful, an HTTP response will be returned.
                // Here, the received response is forwarded to the client through the outbound endpoint.
                _ = outboundEP -> forward(res);
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
@Description {value:"Sample service add all items by one as a supplyer"}
service<http:Service> addone bind supplyerEP {

    @Description {value:"The passthrough resource allows all HTTP methods since the resource configuration does not explicitly specify which HTTP methods are allowed."}
    @http:ResourceConfig {
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request req) {
        // Calling forward() on the backend client endpoint forwards the request the passthrough resource received to the backend.
        // When forwarding, the request is made using the same HTTP method used to invoke the passthrough resource.
        // The forward() function returns the response from the backend if there weren't any errors.
        var clientResponse = addEP -> forward("/", req);

        // Since forward() can return an error as well, a matcher is required to handle the two cases.
        match clientResponse {
            http:Response res => {
                // If the request was successful, an HTTP response will be returned.
                // Here, the received response is forwarded to the client through the outbound endpoint.
                _ = outboundEP -> forward(res);
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

@Description {value:"Sample service add all items by one as a supplyer"}
service<http:Service> adddata bind supplyerEP {

    @Description {value:"The passthrough resource allows all HTTP methods since the resource configuration does not explicitly specify which HTTP methods are allowed."}
    @http:ResourceConfig {
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request req) {
        // Calling forward() on the backend client endpoint forwards the request the passthrough resource received to the backend.
        // When forwarding, the request is made using the same HTTP method used to invoke the passthrough resource.
        // The forward() function returns the response from the backend if there weren't any errors.
        var clientResponse = adddataEP -> forward("/", req);

        // Since forward() can return an error as well, a matcher is required to handle the two cases.
        match clientResponse {
            http:Response res => {
                // If the request was successful, an HTTP response will be returned.
                // Here, the received response is forwarded to the client through the outbound endpoint.
                _ = outboundEP -> forward(res);
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
@Description {value:"Sample service add all items by one as a supplyer"}
service<http:Service> deletedata bind supplyerEP {

    @Description {value:"The passthrough resource allows all HTTP methods since the resource configuration does not explicitly specify which HTTP methods are allowed."}
    @http:ResourceConfig {
        path:"/"
    }
    passthrough (endpoint outboundEP, http:Request req) {
        // Calling forward() on the backend client endpoint forwards the request the passthrough resource received to the backend.
        // When forwarding, the request is made using the same HTTP method used to invoke the passthrough resource.
        // The forward() function returns the response from the backend if there weren't any errors.
        var clientResponse = deletedataEP -> forward("/", req);

        // Since forward() can return an error as well, a matcher is required to handle the two cases.
        match clientResponse {
            http:Response res => {
                // If the request was successful, an HTTP response will be returned.
                // Here, the received response is forwarded to the client through the outbound endpoint.
                _ = outboundEP -> forward(res);
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

