codeunit 50001 "Approval Mgmnt. Ext(hr)"
{

    trigger OnRun()
    begin

    end;

    var
        WorkflowMngnt: Codeunit 1501;
        WorkFlowEventHandlingHR: Codeunit "Workflow Event Handling (hr)";
        NoWorkFlowEnabledErr: TextConst ENU = 'No Approval WorkFlow for this record type is enables';
        UnsupportedRecordTypeErr: Label 'Record type %1 is not supported by this workflow response.', Comment = 'Record type Customer is not supported by this workflow response.';
        NothingToApproveErr: TextConst ENU = 'Lines Must Contain Record(s)';


    /////////////////////////////*******************ACTION TRIGGERS*******************************/////////////////////////
    /// 
    /// START OF leave
    [IntegrationEvent(false, false)]
    procedure OnSendLeaveApplicationForApproval(var LeaveApplication: Record "HRM-Leave Requisition")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveApplicationForApproval(var LeaveApplication: Record "HRM-Leave Requisition")
    begin

    end;
    /// END OF leave TRIGGERS



    /// START OF Payroll TRIGGERS
    [IntegrationEvent(false, false)]
    procedure OnSendPayrollForApproval(var Payroll: Record "PRL-Payroll Periods")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPayrollForApproval(var Payroll: Record "PRL-Payroll Periods")
    begin

    end;
    /// END OF Payroll TRIGGERS
    ///  EMPLOYEE REQ
    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeRequisitionForApproval(var EmployeeRequsition: Record "HRM-Employee Requisitions")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeRequisitionForApproval(var EmployeeRequsition: Record "HRM-Employee Requisitions")
    begin

    end;

    /// END OF EMPLOYEE REQ

    /// ///  Training Applicaction
    [IntegrationEvent(false, false)]
    procedure OnSendTrainingApplicationForApproval(var TrainingApplication: Record "HRM-Training Applications")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTrainingApplicationForApproval(var TrainingApplication: Record "HRM-Training Applications")
    begin

    end;

    /// END OFTraining Application
    /// 

    ///  Training Needs
    [IntegrationEvent(false, false)]
    procedure OnSendTrainingNeedsForApproval(var TrainingNeeds: Record "HRM-Training Needs Analysis")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTrainingNeedsForApproval(var TrainingNeeds: Record "HRM-Training Needs Analysis")
    begin

    end;

    /// END OF ETraininng Needs


    ///  Exit Interviews
    [IntegrationEvent(false, false)]
    procedure OnSendExtiInterviewsForApproval(var ExitInterviews: Record "HRM-Employee Exit Interviews")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelExitInterviewsForApproval(var ExitInterviews: Record "HRM-Employee Exit Interviews")
    begin

    end;

    /// END OF Exit Interviews

    ///  HRM-Company Activities
    [IntegrationEvent(false, false)]
    procedure OnSendCompanyActivitiesForApproval(var CompanyActivities: Record "HRM-Company Activities")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelCompanyInterviewsForApproval(var CompanyActivities: Record "HRM-Company Activities")
    begin

    end;

    /// HRM-Company Activities


    /////////////////////////////*******************END OF ACTION TRIGGERS*******************************/////////////////////////


    //////////////////////***************************Check if workflow is activated*************/////////////////////////////
    //leave FUNCTIONS
    procedure CheckLeaveApplicationApprovalPossible(var LeaveApplication: Record "HRM-Leave Requisition"): Boolean
    begin
        if not IsLeaveApplicationApprovalWorkFlowEnable(LeaveApplication) then
            Error(NoWorkflowEnabledErr);

        // if not LeaveApplication.PayLinesExistNew then
        //     Error(NothingToApproveErr);

        // OnAfterCheckLeaveApplicationPossible(LeaveApplication);

        exit(true);
    end;


    procedure IsLeaveApplicationApprovalWorkFlowEnable(var LeaveApplication: Record "HRM-Leave Requisition"): Boolean
    begin
        exit(WorkflowMngnt.CanExecuteWorkflow(LeaveApplication, WorkFlowEventHandlingHR.RunWorkFlowOnSendLeaveApplicationForApprovalCode));
    end;

    procedure CheckLeaveApplicationApprovalWorkflowEnabled(var LeaveApplication: Record "HRM-Leave Requisition"): Boolean
    begin
        if LeaveApplication.Status <> LeaveApplication.Status::Open then
            exit(false);

        exit(IsLeaveApplicationApprovalWorkFlowEnable(LeaveApplication));
    end;
    //END leave FUNCTIONS


    //Payroll FUNCTIONS
    procedure CheckPayrollApprovalPossible(var Payroll: Record "PRL-Payroll Periods"): Boolean
    begin
        if not IsPayrollApprovalWorkFlowEnable(Payroll) then
            Error(NoWorkflowEnabledErr);

        // if not Payroll.ImpLinesExist then
        //     Error(NothingToApproveErr);

        // OnAfterCheckLeaveApplicationPossible(LeaveApplication);

        exit(true);
    end;


    procedure IsPayrollApprovalWorkFlowEnable(var Payroll: Record "PRL-Payroll Periods"): Boolean
    begin

        if Payroll.Status <> Payroll.Status::Open then
            exit(false);

        exit(WorkflowMngnt.CanExecuteWorkflow(Payroll, WorkFlowEventHandlingHR.RunWorkFlowOnSendPayrollForApprovalCode));
    end;

    // procedure CheckPayrollApprovalWorkflowEnabled(var Payroll: Record "PRL-Payroll Periods"): Boolean
    // begin
    //     if Payroll.Status <> Payroll.Status::Open then
    //         exit(false);

    //     exit(IsPayrollApprovalWorkFlowEnable(Payroll));
    // end;
    //END Payroll FUNCTIONS


    //Employee req  FUNCTIONS
    procedure CheckEmployeeRequisitionApprovalPossible(var EmployeeRequitision: Record "HRM-Employee Requisitions"): Boolean
    begin
        if not IsEmployeeRequisitionApprovalWorkFlowEnable(EmployeeRequitision) then
            Error(NoWorkflowEnabledErr);

        // if not Payroll.ImpLinesExist then
        //     Error(NothingToApproveErr);

        // OnAfterCheckLeaveApplicationPossible(LeaveApplication);

        exit(true);
    end;


    procedure IsEmployeeRequisitionApprovalWorkFlowEnable(var EmployeeRequisition: Record "HRM-Employee Requisitions"): Boolean
    begin

        if EmployeeRequisition.Status <> EmployeeRequisition.Status::New then
            exit(false);

        exit(WorkflowMngnt.CanExecuteWorkflow(EmployeeRequisition, WorkFlowEventHandlingHR.RunWorkFlowOnSendEmployeeRequisitionForApprovalCode));
    end;

    //END OF CHECKING employee req ACTIVE

    //Training Application  FUNCTIONS
    procedure CheckTrainingApplicationApprovalPossible(var TrainingApplication: Record "HRM-Training Applications"): Boolean
    begin
        if not IsTrainingApplicationApprovalWorkFlowEnable(TrainingApplication) then
            Error(NoWorkflowEnabledErr);


        // if not Payroll.ImpLinesExist then
        //     Error(NothingToApproveErr);

        // OnAfterCheckLeaveApplicationPossible(LeaveApplication);

        exit(true);
    end;


    procedure IsTrainingApplicationApprovalWorkFlowEnable(var TrainingApplication: Record "HRM-Training Applications"): Boolean
    begin

        if TrainingApplication.Status <> TrainingApplication.Status::New then
            exit(false);

        exit(WorkflowMngnt.CanExecuteWorkflow(TrainingApplication, WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingApplicationForApprovalCode));
    end;

    //END OF CHECKING Training Application ACTIVE


    //Training Application  FUNCTIONS
    procedure CheckTrainingNeedsApprovalPossible(var TrainingNeeds: Record "HRM-Training Needs Analysis"): Boolean
    begin
        if not IsTrainingNeedsApprovalWorkFlowEnable(TrainingNeeds) then
            Error(NoWorkflowEnabledErr);

        // if not Payroll.ImpLinesExist then
        //     Error(NothingToApproveErr);

        // OnAfterCheckLeaveApplicationPossible(LeaveApplication);

        exit(true);
    end;


    procedure IsTrainingNeedsApprovalWorkFlowEnable(var TrainingNeeds: Record "HRM-Training Needs Analysis"): Boolean
    begin

        if TrainingNeeds.Status <> TrainingNeeds.Status::New then
            exit(false);

        exit(WorkflowMngnt.CanExecuteWorkflow(TrainingNeeds, WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingNeedsForApprovalCode));
    end;

    //END OF CHECKING Training Application ACTIVE

    //Exit Interviews FUNCTIONS
    procedure CheckExitInterviewsApprovalPossible(var ExitInterviews: Record "HRM-Employee Exit Interviews"): Boolean
    begin
        if not IsExitInterviewsApprovalWorkFlowEnable(ExitInterviews) then
            Error(NoWorkflowEnabledErr);

        // if not Payroll.ImpLinesExist then
        //     Error(NothingToApproveErr);

        // OnAfterCheckLeaveApplicationPossible(LeaveApplication);

        exit(true);
    end;


    procedure IsExitInterviewsApprovalWorkFlowEnable(var ExitInterviews: Record "HRM-Employee Exit Interviews"): Boolean
    begin

        if ExitInterviews.Status <> ExitInterviews.Status::New then
            exit(false);

        exit(WorkflowMngnt.CanExecuteWorkflow(ExitInterviews, WorkFlowEventHandlingHR.RunWorkFlowOnSendExitInterviewsForApprovalCode));
    end;

    //END OF CHECKING Training Application ACTIVE

    //Training Application  FUNCTIONS
    procedure CheckCompanyActivitesApprovalPossible(var CompanyActivites: Record "HRM-Company Activities"): Boolean
    begin
        if not IsCompanyActivitesApprovalWorkFlowEnable(CompanyActivites) then
            Error(NoWorkflowEnabledErr);

        // if not Payroll.ImpLinesExist then
        //     Error(NothingToApproveErr);

        // OnAfterCheckLeaveApplicationPossible(LeaveApplication);

        exit(true);
    end;


    procedure IsCompanyActivitesApprovalWorkFlowEnable(var CompanyActivites: Record "HRM-Company Activities"): Boolean
    begin

        if CompanyActivites.Status <> CompanyActivites.Status::New then
            exit(false);

        exit(WorkflowMngnt.CanExecuteWorkflow(CompanyActivites, WorkFlowEventHandlingHR.RunWorkFlowOnSendCompanyActivitiesForApprovalCode));
    end;

    //END OF CHECKING Training Application ACTIVE

    //////////////////////***************************End Check if workflow is activated*************/////////////////////////////



    ///////////////////////**************************POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry";
    WorkflowStepInstance: Record "Workflow Step Instance")
    var
        LeaveApplication: Record "HRM-Leave Requisition";
        Payroll: Record "PRL-Payroll Periods";
        EmployeeReq: Record "HRM-Employee Requisitions";
        TrainingApplication: Record "HRM-Training Applications";
        TrainingNeeds: Record "HRM-Training Needs Analysis";
        ExitInterview: Record "HRM-Employee Exit Interviews";
        CompanyActivities: Record "HRM-Company Activities";


    begin
        case
            RecRef.Number of
            Database::"HRM-Leave Requisition":
                begin
                    RecRef.SetTable(LeaveApplication);
                    ApprovalEntryArgument."Document No." := LeaveApplication."No.";
                end;
            Database::"HRM-Employee Requisitions":
                begin
                    RecRef.SetTable(EmployeeReq);
                    ApprovalEntryArgument."Document No." := EmployeeReq."Requisition No.";
                end;

            Database::"HRM-Training Applications":
                begin
                    RecRef.SetTable(TrainingApplication);
                    ApprovalEntryArgument."Document No." := TrainingApplication."Application No";
                end;
            Database::"HRM-Training Needs Analysis":
                begin
                    RecRef.SetTable(TrainingNeeds);
                    ApprovalEntryArgument."Document No." := TrainingNeeds.Code;
                end;
            Database::"HRM-Employee Exit Interviews":
                begin
                    RecRef.SetTable(ExitInterview);
                    ApprovalEntryArgument."Document No." := ExitInterview."Exit Clearance No";
                end;
            Database::"HRM-Company Activities":
                begin
                    RecRef.SetTable(CompanyActivities);
                    ApprovalEntryArgument."Document No." := CompanyActivities.Code;
                end;

        end;
    end;

    //////////////////////**************************END OF POPULATE APPROVAL ENTRY AGRUMENT*****************////////////////////



    //ADDEDD LATER
    [IntegrationEvent(false, false)]
    local procedure OnAfterCheckLeaveApplicationPossible(var LeaveApplication: Record "HRM-Leave Requisition")
    begin
    end;

}