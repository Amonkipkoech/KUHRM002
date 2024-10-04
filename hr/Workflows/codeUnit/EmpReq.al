// codeunit 50001 EmpReqCodeunit
// {
//     trigger OnRun()
//     begin

//     end;

//     [IntegrationEvent(false, false)]
//     PROCEDURE OnSendEmpReqApproval(VAR EmpReq: Record "HRM-Employee Requisitions");
//     begin
//     end;

//     procedure IsEmpReqEnabled(var EmpReq: Record "HRM-Employee Requisitions"): Boolean
//     var
//         WFMngt: Codeunit "Workflow Management";
//         WFCode: Codeunit "EmpReq Work Flow";
//     begin
//         exit(WFMngt.CanExecuteWorkflow(EmpReq, WFCode.RunWorkflowOnSendEmpReqApprovalCode()))
//     end;

//     local procedure CheckWorkflowEnabled(): Boolean
//     var
//         EmpReq: Record "HRM-Employee Requisitions";
//         NoWorkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type',
//          ENG = 'No workflow Enabled for this Record type';
//     begin
//         if not IsEmpReqEnabled(EmpReq) then
//             Error(NoWorkflowEnb);
//     end;


//     //Added modifications
//     local procedure ShowEmpReqApprovalStatus(EmpReq: Record "HRM-Employee Requisitions")
//     begin
//         EmpReq.Find;

//         case EmpReq.Status of
//             EmpReq.Status::Approved:
//                 Message(DocStatusChangedMsg, '', EmpReq."Job ID", EmpReq.Status);
//             EmpReq.Status::"Pending Approval":
//                 if HasOpenOrPendingApprovalEntries(EmpReq.RecordId) then
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
