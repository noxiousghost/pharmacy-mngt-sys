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
    $group: {
      _id: null,
      customers: {
        $addToSet: {
          firstName: "$customerInfo.firstName",
          lastName: "$customerInfo.lastName",
        },
      },
      employees: {
        $addToSet: {
          firstName: "$employeeInfo.firstName",
          lastName: "$employeeInfo.lastName",
        },
      },
    },
  },
  {
    $project: {
      _id: 0,
      people: {
        $setUnion: ["$customers", "$employees"],
      },
    },
  },
]);
