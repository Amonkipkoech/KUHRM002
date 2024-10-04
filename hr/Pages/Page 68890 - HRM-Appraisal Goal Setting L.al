// page 68890 "HRM-Appraisal Goal Setting L"
// {
//     PageType = List;
//     SourceTable = "HRM-Appraisal Goal Setting L";

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 ShowCaption = false;
//                 field("Appraisal No"; Rec."Appraisal No")
//                 {
//                 }
//                 field("Appraisal Period"; Rec."Appraisal Period")
//                 {
//                 }
//                 field("Planned Targets/Objectives"; Rec."Planned Targets/Objectives")
//                 {
//                 }
//                 field("Criteria/Target Date"; Rec."Criteria/Target Date")
//                 {
//                     Caption = 'Assesment Criteria';
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         Updatecontrols();
//     end;

//     trigger OnInit()
//     begin
//         /*Targets:=TRUE;
//         AssesmentCriteria:=TRUE;
//         "Agreement With RatingEditable" := TRUE;
//         ScoreEditable := TRUE;
//         "Appraisal RatingVisible" := TRUE;
//          */

//     end;

//     var
//         HRAppraisalGoalSettingH: Record "HRM-Salary Grades";
//         [InDataSet]
//         "Appraisal RatingVisible": Boolean;
//         [InDataSet]
//         ScoreEditable: Boolean;
//         [InDataSet]
//         "Agreement With RatingEditable": Boolean;
//         Targets: Boolean;
//         AssesmentCriteria: Boolean;

//     procedure Updatecontrols()
//     begin
//         /* HRAppraisalGoalSettingH.SETRANGE(HRAppraisalGoalSettingH."Appraisal No","Appraisal No");
//          IF HRAppraisalGoalSettingH.FIND('-') THEN
//          IF HRAppraisalGoalSettingH.Sent=HRAppraisalGoalSettingH.Sent::"At Appraisee" THEN BEGIN
//          IF Sent<>Sent::"At Appraisee" THEN BEGIN
//          Targets:=TRUE;
//          AssesmentCriteria:=TRUE;
//          "Agreement With RatingEditable" :=TRUE;
//          "Appraisal RatingVisible" :=TRUE;
//          ScoreEditable :=TRUE;
//          CurrPage.Updatecontrols();
//          END ELSE BEGIN
//          Targets:=FALSE;
//          AssesmentCriteria:=FALSE;
//          "Agreement With RatingEditable" :=FALSE;
//          ScoreEditable :=FALSE;
//          CurrPage.Updatecontrols();
//          END;
// */

//     end;
// }

