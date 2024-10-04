// codeunit 50003 TrainReqCodeunit
// {
//     trigger OnRun()
//     begin

//     end;

//     [IntegrationEvent(false, false)]
//     PROCEDURE OnSendTrainReqApproval(VAR TrainReq: Record "HRM-Training Applications");
//     begin
//     end;

//     procedure IsTrainReqEnabled(var TrainReq: Record "HRM-Training Applications"): Boolean
//     var
//         WFMngt: Codeunit "Workflow Management";
//         WFCode: Codeunit "TrainReq Work Flow";
//     begin
//         exit(WFMngt.CanExecuteWorkflow(TrainReq, WFCode.RunWorkflowOnSendTrainReqApprovalCode()))
//     end;

//     local procedure CheckWorkflowEnabled(): Boolean
//     var
//         TrainReq: Record "HRM-Training Applications";
//         NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
//          ENG = 'No workflow Enabled for this Record type';
//     begin
//         if not IsTrainReqEnabled(TrainReq) then
//             Error(NoWorkflowEnb);
//     end;


//     //Added modifications
//     local procedure ShowTrainReqApprovalStatus(TrainReq: Record "HRM-Training Applications")
//     begin
//         TrainReq.Find;

//         case TrainReq.Status of
//             TrainReq.Status::Approved:
//                 Message(DocStatusChangedMsg, '', TrainReq."Application No", TrainReq.Status);
//             TrainReq.Status::"Pending Approval":
//                 if HasOpenOrPendingApprovalEntries(TrainReq.RecordId) then
//                     Message(PendingApprovalMsg);

//         end;
//     end;

//     procedure HasOpenOrPendingApprovalEntries(RecordID: RecordID): Boolean
//     var
//         ApprovalEntry: Record "Approval Entry";
//     begin
//         ApprovalEntry.SetRange("Table ID", RecordID.TableNo);
//         ApprovalEntry.SetRange("Record ID to Approve", RecordID);
//         ApprovalEntry.SetFilter(Status, '%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
//         ApprovalEntry.SetRange("Related to Change", false);
//         exit(not ApprovalEntry.IsEmpty);
//     end;



//     var
//         myInt: Integer;
//         DocStatusChangedMsg: Label '%1 %2 has been automatically approved. The status has been changed to %3.',
//           Comment = 'Order 1001 has been automatically approved. The status has been changed to Released.';
//         PendingApprovalMsg: Label 'An approval request has been sent.';
// }
