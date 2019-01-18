const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient({ region: 'us-east-1' });
const tableName = 'alcolytics-drinks';

exports.handler = async (event) => {
   if(event.context){
      if (event.context['resource-path'] === '/drinks') {
         if (event.context['http-method'] === 'GET') {
            let userId = event['params'].querystring.userId;
            let startTime = event['params'].querystring.startTime || 0;
            let endTime = event['params'].querystring.endTime || 999999999999999;
            let queryParams = {
               TableName: tableName,
               KeyConditionExpression: "#uid = :uid AND #time BETWEEN :starttime AND :endtime",
               ExpressionAttributeNames: {
                "#uid": "userId",
                "#time": "timestamp"
               },
               ExpressionAttributeValues: {
                ":uid": userId,
                ":starttime": startTime,
                ":endtime": endTime
               }
            }
            
            return new Promise((resolve, reject) => {
               docClient.query(queryParams, function(err, data) {
                   if (err) {
                        return reject({
                           "error": err
                        });
                   } else {
                        return resolve({
                           "success": "Data successfully retrieved",
                           "data": data.Items
                        });
                   }
                });
            });
            
         } else if (event.context['http-method'] === 'POST') {
            let userId = event['body-json'].userId;
            let rawAbv = Number(event['body-json'].abv);
            let rawVolume = Number(event['body-json'].volume);
            let adjustedVolume = Number((rawVolume * 29.5735) / 1000);
            let gramsOfAlcohol = Number(((rawAbv / 100) * 789.24) * adjustedVolume);
            let timestamp = Date.now();
            let drinkDataPoint = {
               "userId": userId,
               "abv": rawAbv,
               "volume": rawVolume,
               "gramsOfAlcohol": gramsOfAlcohol,
               "timestamp": timestamp
            };
            
            return new Promise((resolve, reject) => {
               docClient.put({
                   TableName: tableName,
                   Item: drinkDataPoint
                }, function(err, data) {
                    if (err) {
                        return reject({
                           "error": err
                        });
                    } else {
                        return resolve({
                           "success": "Drink successfully added to database",
                           "data": drinkDataPoint
                        });
                    }
                });
            });
         }else{
            return {"error": "Valid http method not found"}
         }
      }else{
         return {"error": "Valid resource path not found"}
      }
   }else{
      return {"error": "event.context not found"}
   }
};