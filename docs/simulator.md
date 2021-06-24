# Running the simulator

With the Docker containers running and required objects and entities created, we are now ready to start the simulation. The workflow shall consist of the following steps:

1. Checking that all created entities are present in the ORION context broker.
2. Creating a simulated work order and checking that it correctly enters the system.
3. When the scheduled time for the work order arrives, checking that the robot simulator begins "moving" and correctly communicates this to the rest of the system.
4. Let the work order be completed and check that this is correctly translated to the system.

## Initial check

Firstly, we will check that all entities created in the previous step are present in the ORION context broker. For this, we use Postman with the previously imported collection.

1. Go to `orion > entities` and select `get entities by type`
2. In the "Params" section of the request, check "type=AMR"
3. Send the request
4. The response should be a "200 OK" with the following data (`...` represents the details of each attribute -- too long to place here):
```json
[
    {
        "id": "urn:ngsi-ld:AMR:aabbccddeeff",
        "type": "AMR",
        "action": {...},
        "available": {...},
        "battery": {...},
        "connectivity": {...},
        "dateCreated": {...},
        "dateModified": {...},
        "heartbeat": {...},
        "location": {...},
        "name": {...},
        "pendingDestination": {...},
        "refDestination": {...},
        "refPayload": {...},
        "refWorkOrder": {...},
        "status": {...},
        "version": {...}
        
    }
]
```
5. Next we will check the warehouse, using the same request but with different parameters
6. In the "Params" section of the request, check "type=Warehouse"
7. Send the request
8. The response should be a "200 OK" with the following data (`...` represents the details of each attribute -- too long to place here):
```json
[
    {
        "id": "urn:ngsi-ld:Warehouse:ba0a43d899b744cf9f11619258401e46",
        "type": "Warehouse",
        "dateCreated": {...},
        "dateModified": {...},
        "erpId": {...},
        "location": {...},
        "name": {...},
        "status": {...}
    }
]
```
9. Next we will check the idle station, using the same request but with different parameters
10. In the "Params" section of the request, check "type=Idlestation"
11. Send the request
12. The response should be a "200 OK" with the following data (`...` represents the details of each attribute -- too long to place here)
```json
[
    {
        "id": "urn:ngsi-ld:Idlestation:e8473aa880ff4107a763aa528bba7959",
        "type": "Idlestation",
        "dateCreated": {...},
        "dateModified": {...},
        "location": {...},
        "name": {...},
        "refRobot": {...},
        "status": {...}
    }
]
```
13. Finally we will check the work stations, using the same request but with different parameters
14. In the "Params" section of the request, check "type=Workstation"
15. Send the request
16. The response should be a "200 OK" with the following data (`...` represents the details of each attribute -- too long to place here)
```json
[
    {
        "id": "urn:ngsi-ld:Workstation:5d1794f1448c4791ac66860890e92723",
        "type": "Workstation",
        "dateCreated": {...},
        "dateModified": {...},
        "erpId": {...},
        "location": {...},
        "name": {...},
        "status": {...}
    },
    {
        "id": "urn:ngsi-ld:Workstation:aeff3cb499de4ec5b56d80bf61977759",
        "type": "Workstation",
        "dateCreated": {...},
        "dateModified": {...},
        "erpId": {...},
        "location": {...},
        "name": {...},
        "status": {...}
    }
]
```
**Note:** *there are two workstations due to the previous step where we created two entities with this type.*

## Creating a work order

Since we do not have an ERP system connected to this simulator, we will insert work orders directly into the system, using a CoFFEE endpoint for this very purpose.

1. In the Postman collection, go to `coffee > erp` and select `insert generated`
2. In the "Body" section of the request, paste the following data:
```json
[
    {
        "orderId": "11",
        "materialId": "11",
        "materialDesc": "Material 11",
        "quantity": 12.3,
        "unit": "kg",
        "batch": "QS11",
        "workStationId": "0161",
        "warehouseId": "0075",
        "day": "2021-06-21",
        "hour": "14:20:10"
    }
]
```
**Note:** *make sure the `workStationId` and `warehouseId` exist in the context broker (same as created previously).*

**Note 2:** *change the `day` and `hour` values to a time close to the current time (e.g.: thirty seconds from now).*

3. The response should be a "200 OK" with the following data, showing the internal id of the created work order:

```json
{
    "workOrderIds": [
        "urn:ngsi-ld:WorkOrder:04ded791633a48b48324b32e37c1d1ed"
    ],
    "errors": []
}
```

4. We can check that the work order was correctly inserted by going to `orion > entities`, selecting `get entities by id` and changing the URL of the request to include the previously obtained workorder id:
```shell
{{orion_url}}/v2/entities/urn:ngsi-ld:WorkOrder:04ded791633a48b48324b32e37c1d1ed
```
This should return the full entity as it is saved in the context broker.

## Checking work order execution

When the time scheduled in the previous step arrives, LATTE will send the information for the robot to start moving towards the warehouse, and the robot simulator shall begin "moving", updating its status and location in the context broker. So as to view these interactions, we will use Postman in conjunction with the logs from LATTE and the robot simulator.

1. Launch two terminal sessions:
```shell
$ docker logs -f feats_robot-simulator_1
$ docker logs -f latte-api
```
2. When the work order is triggered, you will be able to see in the LATTE logs that information:
```shell
2021-06-22 14:40:30.012  INFO 1 --- [almadb_Worker-2] c.d.l.s.s.SchedulerTriggerInterceptor    : Trigger TriggerExecuteWorkOrder1624372830001 fired!
2021-06-22 14:40:30.032  INFO 1 --- [almadb_Worker-2] c.dalma.latte.service.WorkOrderService   : Starting execution of work order urn:ngsi-ld:WorkOrder:27db6ce5c47b4d7d89de8edce8ae59fd
2021-06-22 14:40:30.068  INFO 1 --- [almadb_Worker-2] c.dalma.latte.service.util.MetricsUtil   : WORK ORDER STATUS CHANGE urn:ngsi-ld:AMR:aabbccddeeff urn:ngsi-ld:WorkOrder:27db6ce5c47b4d7d89de8edce8ae59fd assigned 2021-06-22T14:40:30.055Z
2021-06-22 14:40:30.113  INFO 1 --- [almadb_Worker-2] c.dalma.latte.service.util.MetricsUtil   : WORK ORDER STATUS CHANGE urn:ngsi-ld:AMR:aabbccddeeff urn:ngsi-ld:WorkOrder:27db6ce5c47b4d7d89de8edce8ae59fd scheduled 2021-06-22T14:40:24.175Z
2021-06-22 14:40:30.114  INFO 1 --- [almadb_Worker-2] c.dalma.latte.service.WorkOrderService   : Execution of work order urn:ngsi-ld:WorkOrder:27db6ce5c47b4d7d89de8edce8ae59fd started with robot urn:ngsi-ld:AMR:aabbccddeeff
2021-06-22 14:40:30.114  INFO 1 --- [almadb_Worker-2] c.d.l.s.s.SchedulerTriggerInterceptor    : Trigger TriggerExecuteWorkOrder1624372830001 completed!
2021-06-22 14:40:31.144  INFO 1 --- [nio-8091-exec-2] c.dalma.latte.service.WorkOrderService   : Executing pending destination urn:ngsi-ld:Warehouse:ba0a43d899b744cf9f11619258401e46 to robot urn:ngsi-ld:AMR:aabbccddeeff

```
3. At the same time, the robot simulator logs will show a series of dots, representing the movement of the robot. When it "arrives" at the destination, it will wait for 5 seconds before sending a simulated "ready" trigger:
```shell
.
.
.
.
.
.
.
.
.
.
Arrived at destination! Waiting for operator input...
.
.
.
.
.
Operator has loaded / unloaded the AMR. Ready for next destination.
```
4. While the robot simulator is working, you can also consult its status on LATTE or the context broker using Postman, by going to `latte > robot > get robots` (LATTE) or `orion > entities > get entities by type (AMR)` (ORION). The coordinates and status should be changing throughout the execution of the work order.
5. The execution of a work order consists of three "trips" made by the robot:
   - From idle station to warehouse: robot was previously idle and needs to collect the raw material
   - From warehouse to workstation: robot is loaded with material at the warehouse and brings it to the operator at the work station
   - From workstation to idle station: robot has finished the delivery and waits for next work order at the idle position.

This means that you will see the previous logs a total of three times.

## Final check

Finally, we can check that the work order was correctly executed and the system recognizes it as such:

1. In Postman go to `orion > entities > get entities by id` and paste the previously obtained workorder id in the URL
2. Send the request
3. The response should return the full information of the work order, namely the `startedAt`, `endedAt` and `status` attribute, with the first two showing the start and end times of the work order, while the `status` should show a value of `ended`.