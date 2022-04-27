import 'package:yodacentral/models/model_pipeline.dart';

List<ModelPipeline> pipeLineFinancing = [
  ModelPipeline(
    id: 1,
    title: "[Unit] Listing",
    category: "Financing",
  ),
  ModelPipeline(
    id: 2,
    title: "[Unit] Not Available",
    category: "Financing",
  ),
  ModelPipeline(
    id: 3,
    title: "[Unit] Visiting",
    category: "Financing",
  ),
  ModelPipeline(
    id: 4,
    title: "[Unit] Visit done",
    category: "Financing",
  ),
  ModelPipeline(
    id: 5,
    title: "Assigning Credit Surveyor",
    category: "Financing",
  ),
  ModelPipeline(
    id: 6,
    title: "[Credit] Surveying",
    category: "Financing",
  ),
  ModelPipeline(
    id: 7,
    title: "[Credit] Approval",
    category: "Financing",
  ),
  ModelPipeline(
    id: 8,
    title: "[Credit] Purchasing order",
    category: "Financing",
  ),
  ModelPipeline(
    id: 9,
    title: "[Credit] Rejected",
    category: "Financing",
  ),
];

List<ModelPipeline> pipeLineRefinancing = [
  ModelPipeline(
    id: 10,
    title: "SLIK Checking",
    category: "Refinancing",
  ),
  ModelPipeline(
    id: 11,
    title: "Assigning Credit Surveyor",
    category: "Refinancing",
  ),
  ModelPipeline(
    id: 12,
    title: "[Credit] Surveying",
    category: "Refinancing",
  ),
  ModelPipeline(
    id: 13,
    title: "[Credit] Approval",
    category: "Refinancing",
  ),
  ModelPipeline(
    id: 14,
    title: "[Credit] Purchasing order",
    category: "Refinancing",
  ),
  ModelPipeline(
    id: 15,
    title: "[Credit] Rejected",
    category: "Refinancing",
  ),
  ModelPipeline(
    id: 16,
    title: "SLIK Rejected",
    category: "Refinancing",
  ),
];


// {
//     "message": "Data Berhasil Didapatkan",
//     "data": {
//         "open": [
//             {
//                 "id": 1,
//                 "title": "[Unit] Listing",
//                 "category": "Financing",
//                 "priority": 1,
//                 "status": "Open",
//                 "total_card": 3
//             },
//             {
//                 "id": 3,
//                 "title": "[Unit] Visiting",
//                 "category": "Financing",
//                 "priority": 3,
//                 "status": "Open",
//                 "total_card": 0
//             },
//             {
//                 "id": 4,
//                 "title": "[Unit] Visit done",
//                 "category": "Financing",
//                 "priority": 4,
//                 "status": "Open",
//                 "total_card": 0
//             },
//             {
//                 "id": 5,
//                 "title": "Assigning Credit Surveyor",
//                 "category": "Financing",
//                 "priority": 5,
//                 "status": "Open",
//                 "total_card": 0
//             },
//             {
//                 "id": 6,
//                 "title": "[Credit] Surveying",
//                 "category": "Financing",
//                 "priority": 6,
//                 "status": "Open",
//                 "total_card": 0
//             },
//             {
//                 "id": 7,
//                 "title": "[Credit] Approval",
//                 "category": "Financing",
//                 "priority": 7,
//                 "status": "Open",
//                 "total_card": 0
//             }
//         ],
//         "close": [
//             {
//                 "id": 2,
//                 "title": "[Unit] Not Available",
//                 "category": "Financing",
//                 "priority": 2,
//                 "status": "Close",
//                 "total_card": 0
//             },
//             {
//                 "id": 8,
//                 "title": "[Credit] Purchasing order",
//                 "category": "Financing",
//                 "priority": 8,
//                 "status": "Close",
//                 "total_card": 0
//             },
//             {
//                 "id": 9,
//                 "title": "[Credit] Rejected",
//                 "category": "Financing",
//                 "priority": 9,
//                 "status": "Close",
//                 "total_card": 0
//             }
//         ]
//     }
// }