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
    $unwind: "$medicineInfo",
  },
  {
    $project: {
      orderId: "$orderId",
      medicineId: "$orderDetails.medicineId",
      medicineName: "$medicineInfo.name",
      pricePerUnit: "$medicineInfo.price",
      quantity: "$orderDetails.quantity",
      totalCost: {
        $multiply: ["$medicineInfo.price", "$orderDetails.quantity"],
      },
    },
  },
  {
    $sort: { orderId: 1, medicineId: 1 },
  },
]);
