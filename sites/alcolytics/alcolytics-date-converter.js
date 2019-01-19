let rawData = ["09/19/2018 19:28:35","09/19/2018 20:28:44","09/20/2018 18:42:55","09/20/2018 19:51:03","09/20/2018 21:49:12","09/21/2018 23:58:22","09/22/2018 14:02:30","09/22/2018 16:01:12","09/22/2018 16:01:20","09/22/2018 17:04:20","09/22/2018 17:46:56","09/22/2018 18:38:57","09/22/2018 20:15:36","09/22/2018 21:33:49","09/22/2018 22:11:04","09/22/2018 23:35:14","09/22/2018 23:35:27","09/22/2018 23:35:38","09/25/2018 22:00:34","09/26/2018 20:58:53","09/27/2018 18:56:55","09/27/2018 20:58:42","09/28/2018 20:33:13","09/29/2018 1:28:42","09/29/2018 15:48:56","09/29/2018 16:22:34","09/29/2018 18:14:32","09/29/2018 19:21:29","09/29/2018 20:10:04","09/29/2018 21:04:12","09/29/2018 21:59:07","10/01/2018 20:42:11","10/02/2018 22:13:14","10/03/2018 20:23:37","10/03/2018 20:25:30","10/05/2018 16:32:49","10/05/2018 19:49:56","10/05/2018 20:43:51","10/05/2018 21:44:56","10/06/2018 19:14:09","10/06/2018 19:14:20","10/06/2018 19:14:54","10/06/2018 19:15:04","10/06/2018 19:43:23","10/06/2018 21:19:45","10/07/2018 21:07:24","10/08/2018 22:26:49","10/09/2018 19:15:03","10/09/2018 19:49:18","10/09/2018 20:40:19","10/09/2018 21:02:33","10/09/2018 21:44:02","10/09/2018 22:22:26","10/09/2018 23:14:14","10/11/2018 19:25:57","10/12/2018 18:58:34","10/12/2018 20:03:53","10/12/2018 22:43:36","10/13/2018 17:53:42","10/13/2018 18:45:02","10/13/2018 18:55:35","10/13/2018 20:23:19","10/13/2018 21:35:55","10/13/2018 22:47:55","10/13/2018 23:15:27","10/16/2018 17:20:09","10/16/2018 17:20:23","10/16/2018 18:18:57","10/16/2018 20:10:51","10/16/2018 20:44:15","10/16/2018 22:42:29","10/18/2018 15:49:28","10/18/2018 16:47:37","10/18/2018 17:34:49","10/18/2018 19:31:27","10/18/2018 21:55:29","10/20/2018 0:38:05","10/20/2018 17:21:04","10/20/2018 18:05:26","10/20/2018 19:30:41","10/20/2018 20:22:04","10/20/2018 20:47:46","10/20/2018 20:52:00","10/21/2018 0:58:36","10/24/2018 20:24:42","10/25/2018 18:39:18","10/25/2018 20:08:35","10/25/2018 23:54:56","10/26/2018 15:25:56","10/26/2018 16:08:18","10/26/2018 18:55:46","10/26/2018 19:49:20","10/26/2018 22:21:22","10/27/2018 21:03:38","10/27/2018 21:50:35","10/27/2018 22:25:02","10/27/2018 23:35:17","10/28/2018 0:38:00","10/28/2018 1:34:25","10/28/2018 1:22:55","10/28/2018 1:23:05","10/31/2018 18:32:26","10/31/2018 18:45:56","10/31/2018 22:34:02","11/02/2018 19:36:56","11/02/2018 21:20:11","11/03/2018 10:08:32","11/03/2018 17:11:18","11/03/2018 19:01:36","11/03/2018 19:57:14","11/03/2018 20:42:42","11/03/2018 21:21:34","11/03/2018 21:59:44","11/03/2018 22:51:46","11/03/2018 23:54:05","11/04/2018 18:14:55","11/06/2018 21:15:29","11/06/2018 22:27:06","11/07/2018 19:15:56","11/07/2018 22:13:36","11/08/2018 18:37:30","11/08/2018 21:43:33","11/09/2018 17:43:49","11/09/2018 18:51:26","11/09/2018 19:34:53","11/09/2018 21:13:29","11/09/2018 22:17:40","11/09/2018 23:21:07","11/10/2018 15:26:30","11/10/2018 17:11:13","11/10/2018 17:16:28","11/10/2018 17:16:40","11/10/2018 18:52:45","11/10/2018 19:14:12","11/10/2018 20:07:58","11/10/2018 21:36:33","11/11/2018 18:22:37","11/11/2018 18:33:36","11/12/2018 19:35:48","11/13/2018 21:53:35","11/14/2018 18:57:50","11/15/2018 18:40:30","11/16/2018 18:36:14","11/17/2018 19:49:28","11/17/2018 21:49:28","11/18/2018 15:01:16","11/18/2018 15:04:24","11/18/2018 16:44:28","11/18/2018 17:20:55","11/18/2018 19:52:32","11/19/2018 20:47:29","11/20/2018 23:30:50","11/21/2018 7:47:06","11/21/2018 18:06:05","11/21/2018 18:06:37","11/21/2018 19:47:13","11/21/2018 21:06:08","11/21/2018 22:01:05","11/22/2018 18:42:39","11/22/2018 19:27:39","11/22/2018 20:27:53","11/22/2018 21:22:36","11/22/2018 22:04:48","11/22/2018 22:23:13","11/23/2018 17:00:47","11/23/2018 17:39:19","11/23/2018 18:11:46","11/23/2018 20:11:31","11/23/2018 21:07:29","11/23/2018 21:36:19","11/24/2018 16:19:30","11/24/2018 17:35:12","11/24/2018 18:12:38","11/24/2018 19:00:25","11/24/2018 20:01:53","11/24/2018 20:18:33","11/24/2018 21:51:42","11/24/2018 22:17:31","11/24/2018 23:09:14","11/25/2018 21:02:28","11/27/2018 15:56:08","11/27/2018 16:19:32","11/28/2018 6:47:43","11/28/2018 20:31:18","11/28/2018 20:31:41","11/29/2018 8:10:42","11/29/2018 19:14:35","11/30/2018 19:56:43","11/30/2018 21:12:14","11/30/2018 23:39:11","12/01/2018 0:16:42","12/01/2018 1:07:42","12/01/2018 18:10:22","12/01/2018 18:10:49","12/01/2018 18:11:03","12/01/2018 18:11:13","12/01/2018 18:21:52","12/01/2018 20:26:13","12/01/2018 20:33:15","12/01/2018 20:33:27","12/01/2018 20:52:33","12/01/2018 21:35:41","12/01/2018 22:33:36","12/03/2018 21:29:36","12/05/2018 21:33:23","12/05/2018 21:33:36","12/06/2018 17:19:09","12/06/2018 17:42:25","12/06/2018 18:55:13","12/06/2018 19:47:41","12/06/2018 20:13:33","12/06/2018 22:25:48","12/06/2018 23:50:47","12/08/2018 17:36:28","12/08/2018 17:54:08","12/08/2018 18:45:45","12/08/2018 19:57:03","12/08/2018 22:34:18","12/08/2018 22:34:33","12/09/2018 0:12:29","12/09/2018 0:12:40","12/09/2018 0:35:21","12/12/2018 19:37:44","12/12/2018 20:35:00","12/14/2018 17:29:47","12/14/2018 17:31:45","12/14/2018 18:45:04","12/14/2018 19:02:04","12/14/2018 21:24:46","12/14/2018 22:28:20","12/14/2018 23:35:14","12/15/2018 0:21:20","12/16/2018 15:16:09","12/16/2018 17:31:58","12/16/2018 21:21:38","12/16/2018 21:21:47","12/17/2018 20:07:56","12/17/2018 21:55:04","12/19/2018 18:50:15","12/19/2018 19:50:11","12/20/2018 16:08:41","12/20/2018 16:40:53","12/20/2018 17:44:51","12/20/2018 18:17:24","12/20/2018 19:01:54","12/20/2018 19:58:05","12/21/2018 17:20:59","12/21/2018 17:51:10","12/21/2018 19:15:49","12/21/2018 20:13:02","12/21/2018 21:58:39","12/22/2018 17:24:03","12/22/2018 18:17:58","12/22/2018 18:36:33","12/22/2018 19:37:24","12/22/2018 20:45:57","12/22/2018 21:43:36","12/22/2018 22:06:51","12/23/2018 14:05:48","12/23/2018 15:47:54","12/23/2018 17:00:41","12/23/2018 18:23:18","12/23/2018 18:42:01","12/23/2018 19:40:53","12/23/2018 21:59:51","12/23/2018 22:01:02","12/23/2018 23:47:39","12/24/2018 17:32:50","12/24/2018 18:33:40","12/24/2018 20:09:01","12/24/2018 22:09:27","12/24/2018 22:21:56","12/25/2018 14:09:43","12/25/2018 18:40:55","12/25/2018 19:15:20","12/25/2018 19:58:03","12/25/2018 21:53:51","12/26/2018 17:54:56","12/26/2018 19:04:00","12/26/2018 20:58:22","12/26/2018 21:46:07","12/31/2018 18:09:19","12/31/2018 19:41:19","12/31/2018 21:55:57","12/31/2018 22:46:16","01/01/2019 0:19:36","01/01/2019 7:48:09","01/01/2019 7:48:19","01/03/2019 18:05:12","01/03/2019 18:31:26","01/03/2019 20:08:09","01/03/2019 21:42:51","01/03/2019 22:55:15","01/03/2019 23:54:40","01/04/2019 8:18:17","01/05/2019 17:26:29","01/05/2019 17:55:00","01/05/2019 19:26:10","01/05/2019 20:31:17","01/05/2019 22:03:04","01/05/2019 23:07:06","01/06/2019 0:35:06","01/06/2019 1:01:29","01/11/2019 18:40:54","01/12/2019 7:38:37","01/12/2019 14:04:28","01/12/2019 15:45:56","01/12/2019 19:18:36","01/12/2019 20:01:45","01/12/2019 20:39:52","01/12/2019 23:15:40","01/13/2019 2:21:33"];
let rawData = ["01/13/2019 16:46:16", "01/13/2019 17:07:37", "01/16/2019 20:51:08", "01/17/2019 19:13:25", "01/17/2019 22:28:25", "01/18/2019 19:22:00", "01/18/2019 21:32:47", "01/18/2019 22:49:19"];
for(let i = 0; i < rawData.length; i += 1){
    let thisDate = new Date(rawData[i]);
    console.log(thisDate.getTime());
}



/*


1537403315000
1537406924000
1537486975000
1537491063000
1537498152000
1537592302000
1537642950000
1537650072000
1537650080000
1537653860000
1537656416000
1537659537000
1537665336000
1537670029000
1537672264000
1537677314000
1537677327000
1537677338000
1537930834000
1538013533000
1538092615000
1538099922000
1538184793000
1538202522000
1538254136000
1538256154000
1538262872000
1538266889000
1538269804000
1538273052000
1538276347000
1538444531000
1538536394000
1538616217000
1538616330000
1538775169000
1538786996000
1538790231000
1538793896000
1538871249000
1538871260000
1538871294000
1538871304000
1538873003000
1538878785000
1538964444000
1539055609000
1539130503000
1539132558000
1539135619000
1539136953000
1539139442000
1539141746000
1539144854000
1539303957000
1539388714000
1539392633000
1539402216000
1539471222000
1539474302000
1539474935000
1539480199000
1539484555000
1539488875000
1539490527000
1539728409000
1539728423000
1539731937000
1539738651000
1539740655000
1539747749000
1539895768000
1539899257000
1539902089000
1539909087000
1539917729000
1540013885000
1540074064000
1540076726000
1540081841000
1540084924000
1540086466000
1540086720000
1540101516000
1540430682000
1540510758000
1540516115000
1540529696000
1540585556000
1540588098000
1540598146000
1540601360000
1540610482000
1540692218000
1540695035000
1540697102000
1540701317000
1540705080000
1540708465000
1540707775000
1540707785000
1541028746000
1541029556000
1541043242000
1541205416000
1541211611000
1541257712000
1541283078000
1541289696000
1541293034000
1541295762000
1541298094000
1541300384000
1541303506000
1541307245000
1541376895000
1541560529000
1541564826000
1541639756000
1541650416000
1541723850000
1541735013000
1541807029000
1541811086000
1541813693000
1541819609000
1541823460000
1541827267000
1541885190000
1541891473000
1541891788000
1541891800000
1541897565000
1541898852000
1541902078000
1541907393000
1541982157000
1541982816000
1542072948000
1542167615000
1542243470000
1542328830000
1542414974000
1542505768000
1542512968000
1542574876000
1542575064000
1542581068000
1542583255000
1542592352000
1542682049000
1542778250000
1542808026000
1542845165000
1542845197000
1542851233000
1542855968000
1542859265000
1542933759000
1542936459000
1542940073000
1542943356000
1542945888000
1542946993000
1543014047000
1543016359000
1543018306000
1543025491000
1543028849000
1543030579000
1543097970000
1543102512000
1543104758000
1543107625000
1543111313000
1543112313000
1543117902000
1543119451000
1543122554000
1543201348000
1543355768000
1543357172000
1543409263000
1543458678000
1543458701000
1543500642000
1543540475000
1543629403000
1543633934000
1543642751000
1543645002000
1543648062000
1543709422000
1543709449000
1543709463000
1543709473000
1543710112000
1543717573000
1543717995000
1543718007000
1543719153000
1543721741000
1543725216000
1543894176000
1544067203000
1544067216000
1544138349000
1544139745000
1544144113000
1544147261000
1544148813000
1544156748000
1544161847000
1544312188000
1544313248000
1544316345000
1544320623000
1544330058000
1544330073000
1544335949000
1544335960000
1544337321000
1544665064000
1544668500000
1544830187000
1544830305000
1544834704000
1544835724000
1544844286000
1544848100000
1544852114000
1544854880000
1544994969000
1545003118000
1545016898000
1545016907000
1545098876000
1545105304000
1545267015000
1545270611000
1545343721000
1545345653000
1545349491000
1545351444000
1545354114000
1545357485000
1545434459000
1545436270000
1545441349000
1545444782000
1545451119000
1545521043000
1545524278000
1545525393000
1545529044000
1545533157000
1545536616000
1545538011000
1545595548000
1545601674000
1545606041000
1545610998000
1545612121000
1545615653000
1545623991000
1545624062000
1545630459000
1545694370000
1545698020000
1545703741000
1545710967000
1545711716000
1545768583000
1545784855000
1545786920000
1545789483000
1545796431000
1545868496000
1545872640000
1545879502000
1545882367000
1546301359000
1546306879000
1546314957000
1546317976000
1546323576000
1546350489000
1546350499000
1546560312000
1546561886000
1546567689000
1546573371000
1546577715000
1546581280000
1546611497000
1546730789000
1546732500000
1546737970000
1546741877000
1546747384000
1546751226000
1546756506000
1546758089000
1547253654000
1547300317000
1547323468000
1547329556000
1547342316000
1547344905000
1547347192000
1547356540000
1547367693000

1547419576000
1547420857000
1547693468000
1547774005000
1547785705000
1547860920000
1547868767000
1547873359000


*/





var csvData = [
"1546323576000,jonvoth,4.5,12.00,12.60391814",
"1546350489000,jonvoth,45,1.00,10.50326511",
"1546350499000,jonvoth,16,3.00,11.20348279",
"1546560312000,jonvoth,45,1.00,10.50326511",
"1546561886000,jonvoth,6.2,16.00,23.15386443",
"1546567689000,jonvoth,7,16.00,26.14145984",
"1546573371000,jonvoth,7,16.00,26.14145984",
"1546577715000,jonvoth,7,16.00,26.14145984",
"1546581280000,jonvoth,7,16.00,26.14145984",
"1546611497000,jonvoth,4.5,16.00,16.80522418",
"1546730789000,jonvoth,5.65,12.00,15.82491944",
"1546732500000,jonvoth,7,6.00,9.803047439",
"1546737970000,jonvoth,4.3,16.00,16.05832533",
"1546741877000,jonvoth,7,16.00,26.14145984",
"1546747384000,jonvoth,4.5,16.00,16.80522418",
"1546751226000,jonvoth,5.1,16.00,19.04592074",
"1546756506000,jonvoth,5,12.00,14.00435348",
"1546758089000,jonvoth,5,5.00,5.835147285",
"1547253654000,jonvoth,13,1.00,3.034276588",
"1547300317000,jonvoth,45,1.00,10.50326511",
"1547323468000,jonvoth,7,8.00,13.07072992",
"1547329556000,jonvoth,4.5,16.00,16.80522418",
"1547342316000,jonvoth,7.5,12.00,21.00653023",
"1547344905000,jonvoth,6.2,16.00,23.15386443",
"1547347192000,jonvoth,5.6,16.00,20.91316787",
"1547356540000,jonvoth,40,2.00,18.67247131",
"1547367693000,jonvoth,7,5.00,8.169206199",
"1547419576000,jonvoth,5,0.35,14.00435348",
"1547420857000,jonvoth,7,0.21,11.43688868",
"1547693468000,jonvoth,4.5,0.35,12.60391814",
"1547774005000,jonvoth,4.5,0.35,12.60391814",
"1547785705000,jonvoth,4.5,0.35,12.60391814",
"1547860920000,jonvoth,4.5,0.35,12.60391814",
"1547868767000,jonvoth,5.5,0.35,15.40478883",
"1547873359000,jonvoth,6.5,0.35,18.20565953"
];
for(let i = 0; i < csvData.length; i+=1){
    let output = "{";
    let thisItemSplit = csvData[i].split(',');
    output += '"timestamp":'+thisItemSplit[0];
    output += ',"userId":'+'"'+thisItemSplit[1]+'"';
    output += ',"abv":'+thisItemSplit[2];
    output += ',"volume":'+thisItemSplit[3];
    output += ',"gramsOfAlcohol":'+thisItemSplit[4];
    output += '}'
    console.log(output);
}



/*

{"timestamp":1546323576000,"userId":"jonvoth","abv":4.5,"volume":12.00,"gramsOfAlcohol":12.60391814}
{"timestamp":1546350489000,"userId":"jonvoth","abv":45,"volume":1.00,"gramsOfAlcohol":10.50326511}
{"timestamp":1546350499000,"userId":"jonvoth","abv":16,"volume":3.00,"gramsOfAlcohol":11.20348279}
{"timestamp":1546560312000,"userId":"jonvoth","abv":45,"volume":1.00,"gramsOfAlcohol":10.50326511}
{"timestamp":1546561886000,"userId":"jonvoth","abv":6.2,"volume":16.00,"gramsOfAlcohol":23.15386443}
{"timestamp":1546567689000,"userId":"jonvoth","abv":7,"volume":16.00,"gramsOfAlcohol":26.14145984}
{"timestamp":1546573371000,"userId":"jonvoth","abv":7,"volume":16.00,"gramsOfAlcohol":26.14145984}
{"timestamp":1546577715000,"userId":"jonvoth","abv":7,"volume":16.00,"gramsOfAlcohol":26.14145984}
{"timestamp":1546581280000,"userId":"jonvoth","abv":7,"volume":16.00,"gramsOfAlcohol":26.14145984}
{"timestamp":1546611497000,"userId":"jonvoth","abv":4.5,"volume":16.00,"gramsOfAlcohol":16.80522418}
{"timestamp":1546730789000,"userId":"jonvoth","abv":5.65,"volume":12.00,"gramsOfAlcohol":15.82491944}
{"timestamp":1546732500000,"userId":"jonvoth","abv":7,"volume":6.00,"gramsOfAlcohol":9.803047439}
{"timestamp":1546737970000,"userId":"jonvoth","abv":4.3,"volume":16.00,"gramsOfAlcohol":16.05832533}
{"timestamp":1546741877000,"userId":"jonvoth","abv":7,"volume":16.00,"gramsOfAlcohol":26.14145984}
{"timestamp":1546747384000,"userId":"jonvoth","abv":4.5,"volume":16.00,"gramsOfAlcohol":16.80522418}
{"timestamp":1546751226000,"userId":"jonvoth","abv":5.1,"volume":16.00,"gramsOfAlcohol":19.04592074}
{"timestamp":1546756506000,"userId":"jonvoth","abv":5,"volume":12.00,"gramsOfAlcohol":14.00435348}
{"timestamp":1546758089000,"userId":"jonvoth","abv":5,"volume":5.00,"gramsOfAlcohol":5.835147285}
{"timestamp":1547253654000,"userId":"jonvoth","abv":13,"volume":1.00,"gramsOfAlcohol":3.034276588}
{"timestamp":1547300317000,"userId":"jonvoth","abv":45,"volume":1.00,"gramsOfAlcohol":10.50326511}
{"timestamp":1547323468000,"userId":"jonvoth","abv":7,"volume":8.00,"gramsOfAlcohol":13.07072992}
{"timestamp":1547329556000,"userId":"jonvoth","abv":4.5,"volume":16.00,"gramsOfAlcohol":16.80522418}
{"timestamp":1547342316000,"userId":"jonvoth","abv":7.5,"volume":12.00,"gramsOfAlcohol":21.00653023}
{"timestamp":1547344905000,"userId":"jonvoth","abv":6.2,"volume":16.00,"gramsOfAlcohol":23.15386443}
{"timestamp":1547347192000,"userId":"jonvoth","abv":5.6,"volume":16.00,"gramsOfAlcohol":20.91316787}
{"timestamp":1547356540000,"userId":"jonvoth","abv":40,"volume":2.00,"gramsOfAlcohol":18.67247131}
{"timestamp":1547367693000,"userId":"jonvoth","abv":7,"volume":5.00,"gramsOfAlcohol":8.169206199}
{"timestamp":1547419576000,"userId":"jonvoth","abv":5,"volume":0.35,"gramsOfAlcohol":14.00435348}
{"timestamp":1547420857000,"userId":"jonvoth","abv":7,"volume":0.21,"gramsOfAlcohol":11.43688868}
{"timestamp":1547693468000,"userId":"jonvoth","abv":4.5,"volume":0.35,"gramsOfAlcohol":12.60391814}
{"timestamp":1547774005000,"userId":"jonvoth","abv":4.5,"volume":0.35,"gramsOfAlcohol":12.60391814}
{"timestamp":1547785705000,"userId":"jonvoth","abv":4.5,"volume":0.35,"gramsOfAlcohol":12.60391814}
{"timestamp":1547860920000,"userId":"jonvoth","abv":4.5,"volume":0.35,"gramsOfAlcohol":12.60391814}
{"timestamp":1547868767000,"userId":"jonvoth","abv":5.5,"volume":0.35,"gramsOfAlcohol":15.40478883}
{"timestamp":1547873359000,"userId":"jonvoth","abv":6.5,"volume":0.35,"gramsOfAlcohol":18.20565953}

*/