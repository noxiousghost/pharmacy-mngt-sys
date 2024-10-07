db.Orders.aggregate([
  {
    $lookup: {
      from: "Customer",
      localField: "customerId",
      foreignField: "customerId",
      as: "customerInfo",
    },
  },
  {
    $unwind: {
      path: "$customerInfo",
      preserveNullAndEmptyArrays: true,
    },
  },
  {
    $lookup: {
      from: "Employee",
      localField: "employeeId",
      foreignField: "employeeId",
      as: "employeeInfo",
    },
  },
  {
    $unwind: {
      path: "$employeeInfo",
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
    $project: {
      orderId: "$orderId",
      customerID: "$customerInfo.customerId",
      customerFirstName: "$customerInfo.firstName",
      customerLastName: "$customerInfo.lastName",
      employeeID: "$employeeInfo.employeeId",
      employeeFirstName: "$employeeInfo.firstName",
      employeeLastName: "$employeeInfo.lastName",
      position: "$employeeInfo.position",
      billID: "$billInfo.billId",
      totalAmount: "$billInfo.totalAmount",
      paymentStatus: "$billInfo.paymentStatus",
    },
  },
  { $limit: 5 }, // Limit for testing purposes
]);
