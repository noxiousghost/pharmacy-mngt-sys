db.Orders.aggregate([
  {
    $unwind: "$orderDetails",
  },
  {
    $lookup: {
      from: "Medicine",
      localField: "orderDetails.medicineId",
      foreignField: "medicineId",
      as: "medicineInfo",
    },
  },
  {
    $unwind: {
      path: "$medicineInfo",
      preserveNullAndEmptyArrays: true,
    },
  },
  {
    $lookup: {
      from: "Bill",
      localField: "orderId",
      foreignField: "orderID",
      as: "billInfo",
    },
  },
  {
    $unwind: {
      path: "$billInfo",
      preserveNullAndEmptyArrays: true,
    },
  },
  {
    $group: {
      _id: {
        orderYear: { $year: "$orderDate" },
        orderMonth: { $month: "$orderDate" },
        expYear: { $year: "$medicineInfo.expDate" },
        expMonth: { $month: "$medicineInfo.expDate" },
      },
      totalSales: { $sum: "$billInfo.totalAmount" },
      numberOfOrders: { $sum: 1 },
    },
  },
  {
    $sort: {
      "_id.orderYear": 1,
      "_id.orderMonth": 1,
      "_id.expYear": 1,
      "_id.expMonth": 1,
    },
  },
]);
