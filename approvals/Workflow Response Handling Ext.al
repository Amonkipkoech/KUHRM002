codeunit  50004 "Workflow Response Handling(hr)"
{

    trigger OnRun()
    begin

    end;

    ///////////////////************ RE-OPEN DOCUMENT *******//////////////////////

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        LeaveApplication: Record "HRM-Leave Requisition";
        Payroll: Record "PRL-Payroll Periods";
        EmployeeReq: Record "HRM-Employee Requisitions";
        TrainingApplication: Record "HRM-Training Applications";
        TrainingNeeds: Record "HRM-Training Needs Analysis";
        ExitInterview: Record "HRM-Employee Exit Interviews";
        CompanyActivities: Record "HRM-Company Activities";
    begin
        case RecRef.Number of
            database::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::Open;
                    LeaveApplication.Modify();
                    Handled := true;
                end;
            database::"PRL-Payroll Periods":
                begin
                    RecRef.SetTable(Payroll);
                    Payroll.Status := Payroll.Status::open;
                    Payroll.Modify();
                    Handled := true;
                end;
            database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(EmployeeReq);
                    EmployeeReq.Status := EmployeeReq.Status::New;
                    EmployeeReq.Modify();
                    Handled := true;
                end;
            database::"HRM-Training Applications":
                begin
                    RecRef.SetTable(TrainingApplication);
                    TrainingApplication.Status := TrainingApplication.Status::New;
                    TrainingApplication.Modify();
                    Handled := true;
                end;
            database::"HRM-Training Needs Analysis":
                begin
                    RecRef.SetTable(TrainingNeeds);
                    TrainingNeeds.Status := TrainingNeeds.Status::New;
                    TrainingNeeds.Modify();
                    Handled := true;
                end;
            database::"HRM-Employee Exit Interviews":
                begin
                    RecRef.SetTable(ExitInterview);
                    ExitInterview.Status := ExitInterview.Status::New;
                    ExitInterview.Modify();
                    Handled := true;
                end;
            database::"HRM-Company Activities":
                begin
                    RecRef.SetTable(CompanyActivities);
                    CompanyActivities.Status := CompanyActivities.Status::New;
                    CompanyActivities.Modify();
                    Handled := true;
                end;

        end;
    end;

    ///////////////////************ SET STATUS TO APPROVED/RELEASED*******//////////////////////

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        LeaveApplication: Record "HRM-Leave Requisition";
        Payroll: Record "PRL-Payroll Periods";
        EmployeeReq: Record "HRM-Employee Requisitions";
        TrainingApplication: Record "HRM-Training Applications";
        TrainingNeeds: Record "HRM-Training Needs Analysis";
        ExitInterview: Record "HRM-Employee Exit Interviews";
        CompanyActivities: Record "HRM-Company Activities";

    begin
        case RecRef.Number of
            database::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::Released;
                    LeaveApplication.Modify();
                    Handled := true;
                end;
            database::"PRL-Payroll Periods":
                begin
                    RecRef.SetTable(Payroll);
                    Payroll.Status := Payroll.Status::Approved;
                    Payroll.Modify();
                    Handled := true;
                end;
            database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(EmployeeReq);
                    EmployeeReq.Status := EmployeeReq.Status::Approved;
                    EmployeeReq.Modify();
                    Handled := true;
                end;
            database::"HRM-Training Applications":
                begin
                    RecRef.SetTable(TrainingApplication);
                    TrainingApplication.Status := TrainingApplication.Status::Approved;
                    TrainingApplication.Modify();
                    Handled := true;
                end;
            database::"HRM-Training Needs Analysis":
                begin
                    RecRef.SetTable(TrainingNeeds);
                    TrainingNeeds.Status := TrainingNeeds.Status::Approved;
                    TrainingNeeds.Modify();
                    Handled := true;
                end;
            database::"HRM-Employee Exit Interviews":
                begin
                    RecRef.SetTable(ExitInterview);
                    ExitInterview.Status := Payroll.Status::Approved;
                    ExitInterview.Modify();
                    Handled := true;
                end;
            database::"HRM-Company Activities":
                begin
                    RecRef.SetTable(CompanyActivities);
                    CompanyActivities.Status := CompanyActivities.Status::Approved;
                    CompanyActivities.Modify();
                    Handled := true;
                end;

        end;
    end;

    ///////////////////************ SET STATUS TO PENDING APPROVAL *******//////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        LeaveApplication: Record "HRM-Leave Requisition";
        Payroll: Record "PRL-Payroll Periods";
        EmployeeReq: Record "HRM-Employee Requisitions";
        TrainingApplication: Record "HRM-Training Applications";
        TrainingNeeds: Record "HRM-Training Needs Analysis";
        ExitInterview: Record "HRM-Employee Exit Interviews";
        CompanyActivities: Record "HRM-Company Activities";

    begin
        case RecRef.Number of
            database::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::"Pending Approval";
                    LeaveApplication.Modify();
                    IsHandled := true;
                end;
            database::"PRL-Payroll Periods":
                begin
                    RecRef.SetTable(Payroll);
                    Payroll.Status := Payroll.Status::"Pending Approval";
                    Payroll.Modify();
                    IsHandled := true;
                end;
            database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(EmployeeReq);
                    EmployeeReq.Status := EmployeeReq.Status::"Pending Approval";
                    EmployeeReq.Modify();
                    IsHandled := true;
                end;
            database::"HRM-Training Applications":
                begin
                    RecRef.SetTable(TrainingApplication);
                    TrainingApplication.Status := TrainingApplication.Status::"Pending Approval";
                    TrainingApplication.Modify();
                    IsHandled := true;
                end;
            database::"HRM-Training Needs Analysis":
                begin
                    RecRef.SetTable(TrainingNeeds);
                    TrainingNeeds.Status := TrainingNeeds.Status::"Pending Approval";
                    TrainingNeeds.Modify();
                    IsHandled := true;
                end;
            database::"HRM-Employee Exit Interviews":
                begin
                    RecRef.SetTable(ExitInterview);
                    ExitInterview.Status := ExitInterview.Status::"Pending Approval";
                    ExitInterview.Modify();
                    IsHandled := true;
                end;
            database::"HRM-Company Activities":
                begin
                    RecRef.SetTable(CompanyActivities);
                    CompanyActivities.Status := CompanyActivities.Status::"Pending Approval";
                    CompanyActivities.Modify();
                    IsHandled := true;
                end;

        end;
    end;

    //////////////////////***************************subscribe to publisher integration event*************/////////////////////////////

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkFlowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkFlowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit 1521;
        WorkFlowEventHandlingHR: Codeunit "Workflow Event Handling (hr)";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendLeaveApplicationForApprovalCode());//leave
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendPayrollForApprovalCode());//Payroll

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendEmployeeRequisitionForApprovalCode());//emp req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingApplicationForApprovalCode());//training app
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingNeedsForApprovalCode());//training needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendExitInterviewsForApprovalCode());//exit
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendCompanyActivitiesForApprovalCode());//activities

                end;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendLeaveApplicationForApprovalCode());//leave
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendPayrollForApprovalCode());//Payroll

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendEmployeeRequisitionForApprovalCode());//Emp red
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingApplicationForApprovalCode());//Training App
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingNeedsForApprovalCode());//Needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendExitInterviewsForApprovalCode());//exit
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(), WorkFlowEventHandlingHR.RunWorkFlowOnSendCompanyActivitiesForApprovalCode());//Activities        

                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelLeaveApplicationForApprovalCode());//leave
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelPayrollForApprovalCode());//Payroll

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode());//emp req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelTrainingApplicationForApprovalCode());//training appl
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelTrainingNeedsForApprovalCode());//Training needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelExitInterviewsForApprovalCode());//exit interview
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelCompanyActivitiesForApprovalCode());//company activities

                end;
            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelLeaveApplicationForApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelPayrollForApprovalCode());


                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode());//emp req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelTrainingApplicationForApprovalCode());//training appl
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelTrainingNeedsForApprovalCode());//Training needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelExitInterviewsForApprovalCode());//exit interview
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(), WorkFlowEventHandlingHR.RunWorkFlowOnCancelCompanyActivitiesForApprovalCode());//company activities
                end;
        end;

    end;
}

