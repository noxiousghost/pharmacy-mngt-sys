db.Medicine.aggregate([
  {
    $project: {
      medicineId: "$medicineId",
      name: "$name",
      expDate: "$expDate",
      daysRemaining: {
        $subtract: [{ $toDate: "2024-12-31T00:00:00.000Z" }, "$expDate"],
      },
    },
  },
  {
    $project: {
      medicineId: 1,
      name: 1,
      expDate: 1,
      daysRemaining: { $divide: ["$daysRemaining", 1000 * 60 * 60 * 24] },
    },
  },
]);
