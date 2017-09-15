// Sales Queries

//1.)
db.sales.aggregate([
    {$match:{"animal.animalid":{$ne:null}}},
    {$group:{_id: null,
               "Sales_Total":{$sum:{$add:[{$multiply:["$quantity","$saleprice"]},"$salestax"]}}}},
    {$sort:{"Sales_Total":-1}}
])
//1(a). $32308.18 Total

db.sales.aggregate([
    {$match:{"animal.animalid":{$ne:null}}},
    {$group:{_id: "$animal.category",
               "Sales_Total":{$sum:{$add:[{$["$quantity","$saleprice"]},"$salestax"]}},
               }},
    {$sort:{"Sales_Total":-1}}
])
//1(b). $17941.83 - Dogs

db.sales.aggregate([
    {$match:{"animal.animalid":{$ne:null}}},
    {$group:{_id:"$animal.category",
             "TotalCount":{$sum:"$quantity"}}},
    {$sort:{"TotalCount":-1}},
])
//1(c). 95 - Dog

db.sales.aggregate([
    {$match:{"animal.category":{$eq:"Dog"}}},
    {$group:{_id:"$customer.state",
               "Sales_Total":{$sum:{$add:[{$multiply:["$quantity","$saleprice"]},"$salestax"]}},
             "Count_Total":{$sum:"$quantity"}}},
    {$sort:{"Count_Total":-1}},
])
//1(d). $2612.63 - KY - 14 Dog

db.sales.aggregate([
    {$match:{"animal.category":{$eq:"Cat"}}},
    {$group:{_id:{state:"$customer.state",city:"$customer.city"},
               "Sales_Total":{$sum:{$add:[{$multiply:["$quantity","$saleprice"]},"$salestax"]}},
             "Count_Total":{$sum:"$quantity"}}},
    {$sort:{"Sales_Total":-1}},
])
//1(e). Chapel Hill, NC - $614.43 - 3 Cat

db.sales.aggregate([
    {$match:{"animal.animalid":{$ne:null}}},
    {$group:{_id:"$animal.category",
               "Sales_Total":{$sum:{$add:[{$multiply:["$quantity","$saleprice"]},"$salestax"]}},
             "Count_Total":{$sum:"$quantity"}}},
    {$sort:{"Count_Total":1}},
])
//1(f). Spider - $384.92 - 3

// Orders Queries

//2.)
db.orders.aggregate([
    {$group:{_id:{"month":{"$month":"$orderdate"}},
             "Cost_Total":{$sum:{$multiply:["$quantity","$cost"]}},
             "Orders_Tables":{$sum:"$quantity"}}},
    {$sort:{"Count_Total":-1}},
])
//2(a). May - $7818.35 - 4383 Orders

db.orders.aggregate([
    {$project:{Month:{$dateToString:{format:"%m",date:"$orderdate"}},"supplier.name":1,"quantity":1,"cost":1,"shippingcost":1}},
    {$match:{Month:"05"}},
    {$group:{_id:{name:"$supplier.name",Month:"$Month"},
               "Count_Total":{$sum:{$add:[{$multiply:["$quantity","$cost"]},"$shippingcost"]}},
             "Orders_Total":{$sum:"$quantity"}}},
    {$sort:{"Count_Total":-1}},
])
//2(b). Parrish - $2267.54 - 2001 Orders

db.orders.aggregate([
    {$group:{_id:"$supplier.name",
               "TotalAverageShipping":{$avg:"$shippingcost"}}},
    {$sort:{"TotalAverageShipping":-1}}
])
//2(c). Dillard - $55.55

db.orders.aggregate([
    {$group:{_id:"$supplier.state",
               "Shipping_Average":{$avg:"$shippingcost"}}},
    {$sort:{"Shipping_Average":-1}}
])
//2(d). SC with $55.55 in shipping cost

db.orders.aggregate([
    {$match:{"supplier.state":{$eq:"SC"}}},
    {$group:{_id:{"$month":"$orderdate"},
               "Shipping_Total":{$avg:"$shippingcost"}}}
])
//2(e). March - $58.19

/*2f.) I would ship in January due to the low cost in shipping and also 
the total number of orders is lowest, meaning that there wouldn't be a high amount of traffic, 
therefore minimizing the hold-up in order placement and fulfillment. Hardin would be the best supplier to order 
from due to the generally low prices.
*/
