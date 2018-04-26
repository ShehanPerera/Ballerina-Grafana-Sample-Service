# Ballerina-Grafana-Sample-Service

<b>How to use the sample</b>

1.Download the sample service

2.Create a ballerina.conf file adding following lines in ballerina path.
   
  
     [b7a.observability.metrics]
     enabled=true

     [b7a.observability.metrics.prometheus]
     port=9797
     [use 9798,9799 or any port you wish]

3. Run all the services using following commands.You have to use 3 different ballerina,ballerina.conf for this .

           ./ballerina run buyer.bal
           ./ballerina run store.bal
           ./ballerina run supplier.bal
          
4. Check your Prometheus ports for services. (normally one of the get localhost: 9797, you can set other 2 as you need).
 Add ballerina job to prometheus.yml file as follows.

 ``` scrape_configs:
          - job_name: ballerina
       static_configs:
      - targets: ['localhost:9797']
      - targets: ['localhost:9798']
      - targets: ['localhost:9799']
```      

      
5. Run Prometheus

    `./prometheus --config.file=prometheus.yml`

6. Run Grafana (in bin/)

   ` ./grafana-server web`

7. Import Ballerina Metrics Dashboards to Grafana.
8. Run following sample codes for use ballerina service.

This sample uses MySQL DB and before running the sample copy the  MySQL JDBC driver to the BALLERINA_HOME/bre/lib folder and create a database called testdb.

`curl http://localhost:9093/addadata` - To add PRODUCTS table to testdb.

`curl http://localhost:9093/store `-To see data in the table.

`curl http://localhost:9093/addone` -To increase all products count by one.

`curl http://localhost:9091/store` - To get data as a buyer.

`curl http://localhost:9091/buyone` -To decrease all products count by one.

`curl http://localhost:9093/deletedata ` -To drop PRODUCTS table.


<b>Dashboard Screenshots</b> 

Ballerina Http Metrics
![screenshot from 2018-04-16 10-11-44](https://user-images.githubusercontent.com/29086284/38790525-8422efca-415f-11e8-9461-71ebfdcf9e49.png)

Ballerina Http Client Metrics
![screenshot from 2018-04-16 10-11-56](https://user-images.githubusercontent.com/29086284/38790511-5e1dc0a2-415f-11e8-8d72-dab67cbe9c4b.png)

Ballerina SQL Metrics
![screenshot from 2018-04-16 10-11-11](https://user-images.githubusercontent.com/29086284/38790560-adbdb43c-415f-11e8-8049-9ea9924b4d29.png)

Ballerina System Metircs 
![screenshot from 2018-04-16 10-11-28](https://user-images.githubusercontent.com/29086284/38790570-c8da99c4-415f-11e8-9827-9ada226a3d22.png)

Ballerina Http Metrics Overview
![screenshot from 2018-04-16 10-10-30](https://user-images.githubusercontent.com/29086284/38790601-f46fad5e-415f-11e8-8b41-6959f477d997.png)

Ballerina Client Http Metrics Overview
![screenshot from 2018-04-16 10-10-47](https://user-images.githubusercontent.com/29086284/38790612-115c373e-4160-11e8-932e-875a738e92f9.png)

Ballerina SQL Metrics Overview
![screenshot from 2018-04-16 10-11-19](https://user-images.githubusercontent.com/29086284/38790624-2755110a-4160-11e8-9163-a4cda95ff7d0.png)
