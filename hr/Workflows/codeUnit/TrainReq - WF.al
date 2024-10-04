// codeunit 50004 "TrainReq Work Flow"
// {
//     trigger OnRun()
//     begin

//     end;

//     var
//         WFMngt: Codeunit "Workflow Management";
//         AppMgmt: Codeunit "Approvals Mgmt.";
//         WorkflowEventHandling: Codeunit "Workflow Event Handling";
//         WorkflowResponseHandling: Codeunit "Workflow Response Handling";
//         SendTrainReq: TextConst ENU = 'Approval Request for Training  is requested',
//                                 ENG = 'Approval Request for Training  is requested';
//         AppReqTrainReq: TextConst ENU = 'Approval Request for Training  is approved',
//                                 ENG = 'Approval Request for Training  is approved';
//         RejReqTrainReq: TextConst ENU = 'Approval Request for Training  is rejected',
//                                 ENG = 'Approval Request for Training  is rejected';
//         DelReqTrainReq: TextConst ENU = 'Approval Request for Training  is delegated',
//                                 ENG = 'Approval Request for Training  is delegated';
//         SendTrainReqForPendAppTxt: TextConst ENU = 'Status of Training changed to Pending approval',
//                                         ENG = 'Status of Training changed to Pending approval';
//         ReleaseTrainReqTxt: TextConst ENU = 'Release TrainReq', ENG = 'Release TrainReq';
//         ReOpenTrainReqTxt: TextConst ENU = 'ReOpen Training', ENG = 'ReOpen Training';

//     procedure RunWorkflowOnSendTrainReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnSendTrainReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::TrainReqCodeunit, 'OnSendTrainReqApproval', '', false, false)]
//     procedure RunWorkflowOnSendTrainReqApproval(var TrainReq: Record "HRM-Training Applications")
//     begin
//         WFMngt.HandleEvent(RunWorkflowOnSendTrainReqApprovalCode(), TrainReq);
//     end;

//     procedure RunWorkflowOnApproveTrainReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnApproveTrainReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
//     procedure RunWorkflowOnApproveTrainReqApproval(var ApprovalEntry: Record "Approval Entry")
//     begin
//         WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveTrainReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//     end;

//     procedure RunWorkflowOnRejectTrainReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnRejectTrainReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
//     procedure RunWorkflowOnRejectTrainReqApproval(var ApprovalEntry: Record "Approval Entry")
//     begin
//         WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectTrainReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//     end;

//     procedure RunWorkflowOnDelegateTrainReqApprovalCode(): Code[128]
//     begin
//         exit(UpperCase('RunWorkflowOnDelegateTrainReqApproval'))
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
//     procedure RunWorkflowOnDelegateTrainReqApproval(var ApprovalEntry: Record "Approval Entry")
//     begin
//         WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateTrainReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
//     end;

//     procedure SetStatusToPendingApprovalCodeTrainReq(): Code[128]
//     begin
//         exit(UpperCase('Set Status To PendingApproval on Training Requisition'));
//     end;

//     procedure SetStatusToPendingApprovalTrainReq(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TrainReq: Record "HRM-Training Applications";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"HRM-Training Applications":
//                 begin
//                     RecRef.SetTable(TrainReq);
//                     TrainReq.Validate(Status, TrainReq.Status::"Pending Approval");
//                     TrainReq.Modify();
//                     Variant := TrainReq;
//                 end;
//         end;
//     end;

//     procedure ReleaseTrainReqCode(): Code[128]
//     begin
//         exit(UpperCase('Release Training Requisition'));
//     end;

//     procedure ReleaseTrainReq(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         TrainReq: Record "HRM-Training Applications";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReleaseTrainReq(Variant);
//                 end;
//             DATABASE::"HRM-Training Applications":
//                 begin
//                     RecRef.SetTable(TrainReq);
//                     TrainReq.Validate(Status, TrainReq.Status::Approved);
//                     TrainReq.Modify();
//                     Variant := TrainReq;
//                 end;
//         end;
//     end;

//     procedure ReOpenTrainReqCode(): Code[128]
//     begin
//         exit(UpperCase('ReOpen Training Requisition'));
//     end;

//     procedure ReOpenTrainReq(var Variant: Variant)
//     var
//         RecRef: RecordRef;
//         TargetRecRef: RecordRef;
//         ApprovalEntry: Record "Approval Entry";
//         TrainReq: Record "HRM-Training Applications";
//     begin
//         RecRef.GetTable(Variant);
//         case RecRef.Number() of
//             DATABASE::"Approval Entry":
//                 begin
//                     ApprovalEntry := Variant;
//                     TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
//                     Variant := TargetRecRef;
//                     ReOpenTrainReq(Variant);
//                 end;
//             DATABASE::"HRM-Training Applications":
//                 begin
//                     RecRef.SetTable(TrainReq);
//                     TrainReq.Validate(Status, TrainReq.Status::New);
//                     TrainReq.Modify();
//                     Variant := TrainReq;
//                 end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
//     procedure AddTrainReqEventToLibrary()
//     begin
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTrainReqApprovalCode(), Database::"HRM-Training Applications", SendTrainReq, 0, false);

//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveTrainReqApprovalCode(), Database::"Approval Entry", AppReqTrainReq, 0, false);
//         //  WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveTrainReqApprovalCode(), Database::"Approval Entry", ReOpenTrainReqTxt, 0, false);
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectTrainReqApprovalCode(), Database::"Approval Entry", RejReqTrainReq, 0, false);
//         WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateTrainReqApprovalCode(), Database::"Approval Entry", DelReqTrainReq, 0, false);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
//     procedure AddTrainReqRespToLibrary()
//     begin
//         WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeTrainReq(), 0, SendTrainReqForPendAppTxt, 'GROUP 0');
//         WorkflowResponseHandling.AddResponseToLibrary(ReleaseTrainReqCode(), 0, ReleaseTrainReqTxt, 'GROUP 0');
//         WorkflowResponseHandling.AddResponseToLibrary(ReOpenTrainReqCode(), 0, ReOpenTrainReqTxt, 'GROUP 0');
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
//     procedure ExeRespForTrainReq(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
//     var
//         WorkflowResponse: Record "Workflow Response";
//     begin
//         IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
//             case WorkflowResponse."Function Name" of
//                 SetStatusToPendingApprovalCodeTrainReq():
//                     begin
//                         SetStatusToPendingApprovalTrainReq(Variant);
//                         ResponseExecuted := true;
//                     end;
//                 ReleaseTrainReqCode():
//                     begin
//                         ReleaseTrainReq(Variant);
//                         ResponseExecuted := true;
//                     end;
//                 ReOpenTrainReqCode():
//                     begin
//                         ReOpenTrainReq(Variant);
//                         ResponseExecuted := true;
//                     end;
//             end;
//     end;


// }
