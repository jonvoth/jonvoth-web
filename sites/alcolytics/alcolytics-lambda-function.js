const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient({ region: 'us-east-1' });

exports.handler = async (event) => {
   if(event.context){
      if (event.context['resource-path'] === '/drinks') {
         if (event.context['http-method'] === 'GET') {
            //TODO: Return drink data for specified user ID and time period
            let userId = event['body-json'].userId;
            //TODO: syntax in queryParams object isn't working
            let queryParams = {
               TableName: "alcolytics-drinks",
               KeyConditionExpression: "#uid = :uid",
               ExpressionAttributeNames: {
                "#uid": "userId"
               },
               ExpressionAttributeValues: {
                ":uid": userId
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
                           "success": "Values successfully retrieved",
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
               "drinkId": String(userId + "-" + timestamp),
               "abv": rawAbv,
               "volume": rawVolume,
               "gramsOfAlcohol": gramsOfAlcohol,
               "timestamp": timestamp
            };
            
            return new Promise((resolve, reject) => {
               docClient.put({
                   "TableName": "alcolytics-drinks",
                   "Item": drinkDataPoint
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
            //TODO: Return error message
            return {"error": "Valid http method not found"}
         }
      }else{
         //TODO: Return error message
         return {"error": "Valid resource path not found"}
      }
   }else{
      //TODO: Return error message
      return {"error": "event.context not found"}
   }
};