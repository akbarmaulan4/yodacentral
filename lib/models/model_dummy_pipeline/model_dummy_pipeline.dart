class ModelDummyPipeline {
  ModelDummyPipeline({
    required this.id,
    required this.title,
    required this.category,
  });

  int id;
  String title;
  String category;
}

List<ModelDummyPipeline> financing = [
  ModelDummyPipeline(
    id: 1,
    title: "[Unit] Listing",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 3,
    title: "[Unit] Visiting",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 4,
    title: "[Unit] Visit done",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 5,
    title: "Assigning Credit Surveyor",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 6,
    title: "[Credit] Surveying",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 7,
    title: "[Credit] Approval",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 2,
    title: "[Unit] Not Available",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 8,
    title: "[Credit] Purchasing order",
    category: "Financing",
  ),
  ModelDummyPipeline(
    id: 9,
    title: "[Credit] Rejected",
    category: "Financing",
  ),
];

List<ModelDummyPipeline> refinancing = [
  ModelDummyPipeline(
    id: 10,
    title: "SLIK Checking",
    category: "Refinancing",
  ),
  ModelDummyPipeline(
    id: 11,
    title: "Assigning Credit Surveyor",
    category: "Refinancing",
  ),
  ModelDummyPipeline(
    id: 12,
    title: "[Credit] Surveying",
    category: "Refinancing",
  ),
  ModelDummyPipeline(
    id: 13,
    title: "[Credit] Approval",
    category: "Refinancing",
  ),
  ModelDummyPipeline(
    id: 14,
    title: "[Credit] Purchasing order",
    category: "Refinancing",
  ),
  ModelDummyPipeline(
    id: 15,
    title: "[Credit] Rejected",
    category: "Refinancing",
  ),
  ModelDummyPipeline(
    id: 16,
    title: "SLIK Rejected",
    category: "Refinancing",
  ),
];

var a = {
  "message": "Data Berhasil Didapatkan",
  "data": {
    "open": [
      {
        "id": 10,
        "title": "SLIK Checking",
        "category": "Refinancing",
        "priority": 1,
        "status": "Open",
        "total_card": 1
      },
      {
        "id": 11,
        "title": "Assigning Credit Surveyor",
        "category": "Refinancing",
        "priority": 2,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 12,
        "title": "[Credit] Surveying",
        "category": "Refinancing",
        "priority": 3,
        "status": "Open",
        "total_card": 0
      },
      {
        "id": 13,
        "title": "[Credit] Approval",
        "category": "Refinancing",
        "priority": 4,
        "status": "Open",
        "total_card": 0
      }
    ],
    "close": [
      {
        "id": 14,
        "title": "[Credit] Purchasing order",
        "category": "Refinancing",
        "priority": 5,
        "status": "Close",
        "total_card": 0
      },
      {
        "id": 15,
        "title": "[Credit] Rejected",
        "category": "Refinancing",
        "priority": 6,
        "status": "Close",
        "total_card": 0
      },
      {
        "id": 16,
        "title": "SLIK Rejected",
        "category": "Refinancing",
        "priority": 7,
        "status": "Close",
        "total_card": 0
      }
    ]
  }
};
