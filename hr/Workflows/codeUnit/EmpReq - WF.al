// codeunit 50002 "EmpReq Work Flow"
// {
//     trigger OnRun()
//     begin

//     end;

//     var
//         WFMngt: Codeunit "Workflow Management";
//         AppMgmt: Codeunit "Approvals Mgmt.";
//         WorkflowEventHandling: Codeunit "Workflow Event Handling";
//         WorkflowResponseHandling: Codeunit "Workflow Response Handling";
//         SendEmpReq: TextConst ENU = 'Approval Request for Recruitment  is requested',
//                                 ENG = 'Approval Request for Recruitment  is requested';
//         AppReqEmpReq: TextConst ENU = 'Approval Request for Recruitment  is approved',
//                                 ENG = 'Approval Request for Recruitment  is approved';
//         RejReqEmpReq: TextConst ENU = 'Approval Request for Recruitment  is rejected',
//                                 ENG = 'Approval Request for Recruitment  is rejected';
//         DelReqEmpReq: TextConst ENU = 'Approval Request for Recruitment  is delegated',
//                                 ENG = 'Approval Request for Recruitment  is delegated';
//         SendEmpReqForPendAppTxt: TextConst ENU = 'Status of Recruitment changed to Pending approval',
//                                         ENG = 'Status of Recruitment changed to Pending approval';
//         ReleaseEmpReqTxt: TextConst ENU = 'Release EmpReq', ENG = 'Release EmpReq';
//         ReOpenEmpReqTxt: TextConst ENU = 'ReOpen Recruitment', ENG = 'ReOpen Recruitment';

//     procedure RunWorkflowOnSendEmpReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnSendEmpReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::EmpReqCodeunit, 'OnSendEmpReqApproval', '', false, false)]
//     procedure RunWorkflowOnSendEmpReqApproval(var EmpReq: Record "HRM-Employee Requisitions")
//     begin
//         WFMngt.HandleEvent(RunWorkflowOnSendEmpReqApprovalCode(), EmpReq);
//     end;

//     procedure RunWorkflowOnApproveEmpReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnApproveEmpReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
//     procedure RunWorkflowOnApproveEmpReqApproval(var ApprovalEntry: Record "Approval Entry")
//     begin
//         WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveEmpReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//     end;

//     procedure RunWorkflowOnRejectEmpReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnRejectEmpReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
//     procedure RunWorkflowOnRejectEmpReqApproval(var ApprovalEntry: Record "Approval Entry")
//     begin
//         WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectEmpReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//     end;

//     procedure RunWorkflowOnDelegateEmpReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnDelegateEmpReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
//     procedure RunWorkflowOnDelegateEmpReqApproval(var ApprovalEntry: Record "Approval Entry")
//     begin
//         WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateEmpReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//     end;

//     procedure SetStatusToPendingApprovalCodeEmpReq(): Code[128]
//     begin
//         exit(UpperCase('Set Status To PendingApproval on Recruitment Requisition'));
//     end;

//     procedure SetStatusToPendingApprovalEmpReq(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         EmpReq: Record "HRM-Employee Requisitions";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"HRM-Employee Requisitions":
//                 begin
//                     RecRef.SetTable(EmpReq);
//                     EmpReq.Validate(Status, EmpReq.Status::"Pending Approval");
//                     EmpReq.Modify();
//                     Variant := EmpReq;
//                 end;
//         end;
//     end;

//     procedure ReleaseEmpReqCode(): Code[128]
//     begin
//         exit(UpperCase('Release Recruitment Requisition'));
//     end;

//     procedure ReleaseEmpReq(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         EmpReq: Record "HRM-Employee Requisitions";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReleaseEmpReq(Variant);
//                 end;
//             DATABASE::"HRM-Employee Requisitions":
//                 begin
//                     RecRef.SetTable(EmpReq);
//                     EmpReq.Validate(Status, EmpReq.Status::Approved);
//                     EmpReq.Modify();
//                     Variant := EmpReq;
//                 end;
//         end;
//     end;

//     procedure ReOpenEmpReqCode(): Code[128]
//     begin
//         exit(UpperCase('ReOpen Recruitment Requisition'));
//     end;

//     procedure ReOpenEmpReq(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         EmpReq: Record "HRM-Employee Requisitions";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReOpenEmpReq(Variant);
//                 end;
//             DATABASE::"HRM-Employee Requisitions":
//                 begin
//                     RecRef.SetTable(EmpReq);
//                     EmpReq.Validate(Status, EmpReq.Status::New);
//                     EmpReq.Modify();
//                     Variant := EmpReq;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
//     procedure AddEmpReqEventToLibrary()
//     begin
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendEmpReqApprovalCode(), Database::"HRM-Employee Requisitions", SendEmpReq, 0, false);

//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveEmpReqApprovalCode(), Database::"Approval Entry", AppReqEmpReq, 0, false);
//         //  WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveEmpReqApprovalCode(), Database::"Approval Entry", ReOpenEmpReqTxt, 0, false);
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectEmpReqApprovalCode(), Database::"Approval Entry", RejReqEmpReq, 0, false);
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateEmpReqApprovalCode(), Database::"Approval Entry", DelReqEmpReq, 0, false);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
//     procedure AddEmpReqRespToLibrary()
//     begin
//         WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeEmpReq(), 0, SendEmpReqForPendAppTxt, 'GROUP 0');
//         WorkflowResponseHandling.AddResponseToLibrary(ReleaseEmpReqCode(), 0, ReleaseEmpReqTxt, 'GROUP 0');
//         WorkflowResponseHandling.AddResponseToLibrary(ReOpenEmpReqCode(), 0, ReOpenEmpReqTxt, 'GROUP 0');
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
//     procedure ExeRespForEmpReq(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         WorkflowResponse: Record "Workflow Response";
//     begin
//         IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
//             case WorkflowResponse."Function Name" of
//                 SetStatusToPendingApprovalCodeEmpReq():
//                     begin
//                         SetStatusToPendingApprovalEmpReq(Variant);
//                         ResponseExecuted := true;
//                     end;
//                 ReleaseEmpReqCode():
//                     begin
//                         ReleaseEmpReq(Variant);
//                         ResponseExecuted := true;
//                     end;
//                 ReOpenEmpReqCode():
//                     begin
//                         ReOpenEmpReq(Variant);
//                         ResponseExecuted := true;
//                     end;
//             end;
//     end;


// }
