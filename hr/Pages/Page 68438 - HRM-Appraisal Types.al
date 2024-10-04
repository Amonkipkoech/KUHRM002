// page 68438 "HRM-Appraisal Types"
// {
//     PageType = ListPart;
//     SourceTable = "HRM-Appraisal Types";

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                 }
//                 field(Description; Rec.Description)
//                 {
//                 }
//                 field("Max. Weighting"; Rec."Max. Weighting")
//                 {
//                 }
//                 field("Max. Score"; Rec."Max. Score")
//                 {
//                 }
//                 field("Use Template"; Rec."Use Template")
//                 {
//                 }
//                 field("Template Link"; Rec."Template Link")
//                 {
//                 }
//                 field(Remarks; Rec.Remarks)
//                 {
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group(Appraisal)
//             {
//                 Caption = 'Appraisal';
//                 action("Appraisal Format")
//                 {
//                     Caption = 'Appraisal Format';
//                     //todo    RunObject = Page "HRM-Appraisal Formats";
//                     //todo    RunPageLink = "Appraisal Code" = FIELD(Code);
//                 }
//             }
//         }
//     }
// }

