codeunit 50101 "Work Flow Code"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendLeaveReq: TextConst ENU = 'Approval Request for Leave  is requested',
                                ENG = 'Approval Request for Leave  is requested';
        AppReqLeave: TextConst ENU = 'Approval Request for Leave  is approved',
                                ENG = 'Approval Request for Leave  is approved';
        RejReqLeave: TextConst ENU = 'Approval Request for Leave  is rejected',
                                ENG = 'Approval Request for Leave  is rejected';
        DelReqLeave: TextConst ENU = 'Approval Request for Leave  is delegated',
                                ENG = 'Approval Request for Leave  is delegated';
        SendLeaveForPendAppTxt: TextConst ENU = 'Status of Leave changed to Pending approval',
                                        ENG = 'Status of Leave changed to Pending approval';
        ReleaseLeaveTxt: TextConst ENU = 'Release Leave', ENG = 'Release Leave';
        ReOpenLeaveTxt: TextConst ENU = 'ReOpen Leave', ENG = 'ReOpen Leave';


        //PrlApproval REssponses

        //PrlApprovalS
        SendPrlApprovalReq: TextConst ENU = 'Approval Request for PrlApproval is requested', ENG = 'Approval Request for PrlApproval is requested';
        AppReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is approved', ENG = 'Approval Request for PrlApproval is approved';
        RejReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is rejected', ENG = 'Approval Request for PrlApproval is rejected';
        CanReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is cancelled', ENG = 'Approval Request for PrlApproval is cancelled';
        UserCanReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is cancelled by User', ENG = 'Approval Request for PrlApproval is cancelled by User';
        DelReqPrlApproval: TextConst ENU = 'Approval Request for PrlApproval is delegated', ENG = 'Approval Request for PrlApproval is delegated';
        PrlApprovalPendAppTxt: TextConst ENU = 'Status of PrlApproval changed to Pending approval', ENG = 'Status of PrlApproval changed to Pending approval';
        ReleasePrlApprovalTxt: TextConst ENU = 'Release PrlApproval', ENG = 'Release PrlApproval';
        ReOpenPrlApprovalTxt: TextConst ENU = 'ReOpen PrlApproval', ENG = 'ReOpen PrlApproval';
    //END PrlApprovalS
    //End PrlApproval Responses 

    procedure RunWorkflowOnSendLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnSendLeavesforApproval', '', false, false)]
    procedure RunWorkflowOnSendLeaveApproval(var Leave: Record "HRM-Leave Requisition")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendLeaveApprovalCode(), Leave);
    end;

    procedure RunWorkflowOnApproveLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveLeaveApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveLeaveApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectLeaveApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectLeaveApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateLeaveApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateLeaveApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateLeaveApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateLeaveApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodeLeave(): Code[128]
    begin
        exit(UpperCase('Set Status To PendingApproval on Leave'));
    end;

    procedure SetStatusToPendingApprovalLeave(var Variant: Variant)
    var
        RecRef: RecordRef;
        Leave: Record "HRM-Leave Requisition";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::"Pending Approval");
                    Leave.Modify();
                    Variant := Leave;
                end;
        end;
    end;

    procedure ReleaseLeaveCode(): Code[128]
    begin
        exit(UpperCase('Release Leave'));
    end;

    procedure ReleaseLeave(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Leave: Record "HRM-Leave Requisition";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseLeave(Variant);
                end;
            DATABASE::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Released);
                    Leave.autoPostLeave();
                    Leave.Modify();
                    Variant := Leave;
                end;
        end;
    end;

    procedure ReOpenLeaveCode(): Code[128]
    begin
        exit(UpperCase('ReOpen Leave'));
    end;

    procedure ReOpenLeave(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Leave: Record "HRM-Leave Requisition";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenLeave(Variant);
                end;
            DATABASE::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Open);
                    Leave.Modify();
                    Variant := Leave;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddLeaveEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeaveApprovalCode(), Database::"HRM-Leave Requisition", SendLeaveReq, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveLeaveApprovalCode(), Database::"Approval Entry", AppReqLeave, 0, false);
        //  WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveLeaveApprovalCode(), Database::"Approval Entry", ReOpenLeaveTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectLeaveApprovalCode(), Database::"Approval Entry", RejReqLeave, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateLeaveApprovalCode(), Database::"Approval Entry", DelReqLeave, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddLeaveRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeLeave(), 0, SendLeaveForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseLeaveCode(), 0, ReleaseLeaveTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenLeaveCode(), 0, ReOpenLeaveTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForLeave(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeLeave():
                    begin
                        SetStatusToPendingApprovalLeave(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseLeaveCode():
                    begin
                        ReleaseLeave(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenLeaveCode():
                    begin
                        ReOpenLeave(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Start PrlApproval Workflow
    procedure RunWorkflowOnSendPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnSendPrlApprovalforApproval', '', false, false)]
    procedure RunWorkflowOnSendPrlApprovalApproval(var PrlApproval: Record "Prl-Approval")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPrlApprovalApprovalCode(), PrlApproval);
    end;

    procedure RunWorkflowOnApprovePrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnCancelledPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelledPrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnCancelledPrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegatePrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePrlApprovalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePrlApprovalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure SetStatusToPendingApprovalCodePrlApproval(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalPrlApproval'));
    end;

    procedure SetStatusToPendingApprovalPrlApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        PrlApproval: Record "Prl-Approval";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Prl-Approval":
                begin
                    RecRef.SetTable(PrlApproval);
                    PrlApproval.Validate(Status, PrlApproval.Status::"Pending Approval");
                    PrlApproval.Modify();
                    Variant := PrlApproval;
                end;
        end;
    end;

    procedure ReleasePrlApprovalCode(): Code[128]
    begin
        exit(UpperCase('Release PrlApproval'));
    end;

    procedure ReleasePrlApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PrlApproval: Record "Prl-Approval";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleasePrlApproval(Variant);
                end;
            DATABASE::"Prl-Approval":
                begin
                    RecRef.SetTable(PrlApproval);
                    PrlApproval.Validate(Status, PrlApproval.Status::Approved);
                    PrlApproval.ApprovePayroll();
                    PrlApproval.Modify();
                    Variant := PrlApproval;
                end;
        end;
    end;

    procedure ReOpenPrlApprovalCode(): Code[128]
    begin
        exit(UpperCase('ReOpenPrlApproval'));
    end;

    procedure ReOpenPrlApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        PrlApproval: Record "Prl-Approval";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenPrlApproval(Variant);
                end;
            DATABASE::"Prl-Approval":
                begin
                    RecRef.SetTable(PrlApproval);
                    PrlApproval.Validate(Status, PrlApproval.Status::Pending);
                    PrlApproval.Modify();
                    Variant := PrlApproval;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddPrlApprovalEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPrlApprovalApprovalCode(), Database::"Prl-Approval", SendPrlApprovalReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePrlApprovalApprovalCode(), Database::"Approval Entry", AppReqPrlApproval, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPrlApprovalApprovalCode(), Database::"Approval Entry", RejReqPrlApproval, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePrlApprovalApprovalCode(), Database::"Approval Entry", DelReqPrlApproval, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelledPrlApprovalApprovalCode(), Database::"Approval Entry", CanReqPrlApproval, 0, false);
        WorkFlowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPrlApprovalApprovalCode, Database::"Prl-Approval", UserCanReqPrlApproval, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddPrlApprovalRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodePrlApproval(), 0, PrlApprovalPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleasePrlApprovalCode(), 0, ReleasePrlApprovalTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenPrlApprovalCode(), 0, ReOpenPrlApprovalTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForPrlApproval(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodePrlApproval():
                    begin
                        SetStatusToPendingApprovalPrlApproval(Variant);
                        ResponseExecuted := true;
                    end;
                ReleasePrlApprovalCode():
                    begin
                        ReleasePrlApproval(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenPrlApprovalCode():
                    begin
                        ReOpenPrlApproval(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    //Cancelling of PrlApproval Code
    procedure RunWorkflowOnCancelPrlApprovalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPrlApprovalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::IntCodeunit, 'OnCancelPrlApprovalForApproval', '', false, false)]
    procedure RunWorkflowOnCancelPrlApprovalApproval(VAR PrlApproval: Record "Prl-Approval")
    begin

        WFMngt.HandleEvent(RunWorkflowOnCancelPrlApprovalApprovalCode(), PrlApproval);

    end;
    //End Cancelling PrlApproval Code

    //End PrlApproval Workflow


}
