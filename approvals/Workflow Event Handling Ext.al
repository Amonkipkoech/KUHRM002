codeunit  50003 "Workflow Event Handling (hr)"
{
    trigger OnRun()
    begin

    end;

    var
        WorkFlowManagement: Codeunit "Workflow Management";
        WorkFlowEventHandling: Codeunit "Workflow Event Handling";
        //PV
        LeaveApplicationSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Leave Requisition is Requested';

        LeaveApplicationApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Leave Requisition is Canceled';

        //Payroll
        PayrollSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Payroll is Requested';

        PayrollApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Payroll is Canceled';
        //employee req
        EmployeeRequisitionSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Employee Requisition is Requested';

        EmployeeRequisitionApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Employee Requisition is Canceled';
        //training application
        TrainingApplicationSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Training Application is Requested';

        TrainingApplicationApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Training Appplication is Canceled';
        //training needs
        TrainingNeedsSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Training Needs is Requested';

        TrainingNeedsApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Training Needs is Canceled';
        //Exit interviews
        ExitInterviewsSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Exit Interviews is Requested';

        ExitInterviewsApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Exit Interviews is Canceled';
        //company activities
        CompanyActivitiesSentForApprovalEventDescTxt: TextConst ENU = 'Approval of Company Activities is Requested';

        CompanyActivitiesApprovalRequestCancelEventDescTxt: TextConst ENU = 'Approval of Company Activities is Canceled';



    ///////////////////////////////***************************SEND APPROVAL REQUEST*******************************/////////////////////////////

    //Leave
    procedure RunWorkFlowOnSendLeaveApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendLeaveApplicationForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnSendLeaveApplicationForApproval', '', true, true)]
    procedure RunWorkFlowOnSendLeaveApplicationForApproval(var LeaveApplication: Record "HRM-Leave Requisition")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnSendLeaveApplicationForApprovalCode, LeaveApplication);
    end;

    //Payroll
    procedure RunWorkFlowOnSendPayrollForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendPayrollForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnSendPayrollForApproval', '', true, true)]
    procedure RunWorkFlowOnSendPayrollForApproval(var Payroll: Record "PRL-Payroll Periods")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnSendPayrollForApprovalCode, Payroll);
    end;

    //Employee Requisition
    procedure RunWorkFlowOnSendEmployeeRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendEmployeeRequisitionForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnSendEmployeeRequisitionForApproval', '', true, true)]
    procedure RunWorkFlowOnSendEmployeeRequisitionForApproval(var EmployeeRequsition: Record "HRM-Employee Requisitions")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnSendEmployeeRequisitionForApprovalCode, EmployeeRequsition);
    end;

    //Training Application
    procedure RunWorkFlowOnSendTrainingApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendTrainingApplicationForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnSendTrainingApplicationForApproval', '', true, true)]
    procedure RunWorkFlowOnSendTrainingApplicationForApproval(var TrainingApplication: Record "HRM-Training Applications")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnSendTrainingApplicationForApprovalCode, TrainingApplication);
    end;

    //Training Needs
    procedure RunWorkFlowOnSendTrainingNeedsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendTrainingNeedsForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnSendTrainingNeedsForApproval', '', true, true)]
    procedure RunWorkFlowOnSendTrainingNeedsForApproval(var TrainingNeeds: Record "HRM-Training Needs Analysis")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnSendTrainingNeedsForApprovalCode, TrainingNeeds);
    end;
    //Exit Interviews
    procedure RunWorkFlowOnSendExitInterviewsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendExitInterviewsForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnSendExtiInterviewsForApproval', '', true, true)]
    procedure RunWorkFlowOnSendExitInterviewsForApproval(var ExitInterviews: Record "HRM-Employee Exit Interviews")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnSendExitInterviewsForApprovalCode, ExitInterviews);
    end;

    //Company Activities
    procedure RunWorkFlowOnSendCompanyActivitiesForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnSendCompanyActivitiesForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnSendCompanyActivitiesForApproval', '', true, true)]
    procedure RunWorkFlowOnSendCompanyActivitiesForApproval(var CompanyActivities: Record "HRM-Company Activities")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnSendCompanyActivitiesForApprovalCode, CompanyActivities);
    end;

    ////////////////////////////////***************************CANCEL APPROVAL REQUEST*************///////////////////////////////////////////////

    //payment voucher
    procedure RunWorkFlowOnCancelLeaveApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelLeaveApplicationForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnCancelLeaveApplicationForApproval', '', true, true)]
    procedure RunWorkFlowOnCancelLeaveApplicationForApproval(var LeaveApplication: Record "HRM-Leave Requisition")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnCancelLeaveApplicationForApprovalCode, LeaveApplication);
    end;

    //Payroll
    procedure RunWorkFlowOnCancelPayrollForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelPayrollForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnCancelPayrollForApproval', '', true, true)]
    procedure RunWorkFlowOnCancelPayrollForApproval(var Payroll: Record "PRL-Payroll Periods")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnCancelPayrollForApprovalCode, Payroll);
    end;

    //employee req
    procedure RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelEmployeeRequisitionForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnCancelEmployeeRequisitionForApproval', '', true, true)]
    procedure RunWorkFlowOnCancelEmployeeRequisitionForApproval(var EmployeeRequsition: Record "HRM-Employee Requisitions")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode, EmployeeRequsition);
    end;

    //Training Application
    procedure RunWorkFlowOnCancelTrainingApplicationForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelTrainingApplicationForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnCancelTrainingApplicationForApproval', '', true, true)]
    procedure RunWorkFlowOnCancelTrainingApplicationForApproval(var TrainingApplication: Record "HRM-Training Applications")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnCancelTrainingApplicationForApprovalCode, TrainingApplication);
    end;

    //Training Needs
    procedure RunWorkFlowOnCancelTrainingNeedsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelTrainingNeedsForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnCancelTrainingNeedsForApproval', '', true, true)]
    procedure RunWorkFlowOnCancelTrainingNeedsForApproval(var TrainingNeeds: Record "HRM-Training Needs Analysis")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnCancelTrainingNeedsForApprovalCode, TrainingNeeds);
    end;

    //Exit Interviews
    procedure RunWorkFlowOnCancelExitInterviewsForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelExitInterviewsForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnCancelExitInterviewsForApproval', '', true, true)]
    procedure RunWorkFlowOnCancelExitInterviewsForApproval(var ExitInterviews: Record "HRM-Employee Exit Interviews")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnCancelExitInterviewsForApprovalCode, ExitInterviews);
    end;

    //company activities
    procedure RunWorkFlowOnCancelCompanyActivitiesForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkFlowOnCancelCompanyActivitiesForApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Mgmnt. Ext(hr)", 'OnCancelCompanyInterviewsForApproval', '', true, true)]
    procedure RunWorkFlowOnCancelCompanyActivitiesForApproval(var CompanyActivities: Record "HRM-Company Activities")
    begin
        WorkFlowManagement.HandleEvent(RunWorkFlowOnCancelCompanyActivitiesForApprovalCode, CompanyActivities);
    end;

    //////////////////////***************************ADD EVENT TO LIBRARY*************/////////////////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        //pv
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendLeaveApplicationForApprovalCode, Database::"HRM-Leave Requisition", LeaveApplicationSentForApprovalEventDescTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelLeaveApplicationForApprovalCode, Database::"HRM-Leave Requisition", LeaveApplicationApprovalRequestCancelEventDescTxt, 0, false);
        //imrpest
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendPayrollForApprovalCode, Database::"PRL-Payroll Periods", PayrollSentForApprovalEventDescTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelPayrollForApprovalCode, Database::"PRL-Payroll Periods", PayrollApprovalRequestCancelEventDescTxt, 0, false);

        //employee req
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendEmployeeRequisitionForApprovalCode, Database::"HRM-Employee Requisitions", EmployeeRequisitionSentForApprovalEventDescTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode, Database::"HRM-Employee Requisitions", EmployeeRequisitionApprovalRequestCancelEventDescTxt, 0, false);
        //training application
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendTrainingApplicationForApprovalCode, Database::"HRM-Training Applications", TrainingApplicationSentForApprovalEventDescTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelTrainingApplicationForApprovalCode, Database::"HRM-Training Applications", TrainingApplicationApprovalRequestCancelEventDescTxt, 0, false);
        //training needs
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendTrainingNeedsForApprovalCode, Database::"HRM-Training Needs Analysis", TrainingNeedsSentForApprovalEventDescTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelTrainingNeedsForApprovalCode, Database::"HRM-Training Needs Analysis", TrainingNeedsApprovalRequestCancelEventDescTxt, 0, false);
        //exit interviews
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendExitInterviewsForApprovalCode, Database::"HRM-Employee Exit Interviews", ExitInterviewsSentForApprovalEventDescTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelExitInterviewsForApprovalCode, Database::"HRM-Employee Exit Interviews", ExitInterviewsApprovalRequestCancelEventDescTxt, 0, false);
        //company activities
        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnSendCompanyActivitiesForApprovalCode, Database::"HRM-Company Activities", CompanyActivitiesSentForApprovalEventDescTxt, 0, false);

        WorkFlowEventHandling.AddEventToLibrary(RunWorkFlowOnCancelCompanyActivitiesForApprovalCode, Database::"HRM-Company Activities", CompanyActivitiesApprovalRequestCancelEventDescTxt, 0, false);


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkFlowOnCancelLeaveApplicationForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkFlowOnCancelLeaveApplicationForApprovalCode, RunWorkFlowOnSendLeaveApplicationForApprovalCode);
            RunWorkFlowOnCancelPayrollForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkFlowOnCancelPayrollForApprovalCode, RunWorkFlowOnSendPayrollForApprovalCode);

            RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode, RunWorkFlowOnSendEmployeeRequisitionForApprovalCode);

            RunWorkFlowOnCancelTrainingApplicationForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkFlowOnCancelTrainingApplicationForApprovalCode, RunWorkFlowOnSendTrainingApplicationForApprovalCode);
            RunWorkFlowOnCancelTrainingNeedsForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkFlowOnCancelTrainingNeedsForApprovalCode, RunWorkFlowOnSendTrainingNeedsForApprovalCode);

            RunWorkFlowOnCancelExitInterviewsForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkFlowOnCancelExitInterviewsForApprovalCode, RunWorkFlowOnSendExitInterviewsForApprovalCode);

            RunWorkFlowOnCancelCompanyActivitiesForApprovalCode:
                WorkFlowEventHandling.AddEventPredecessor(RunWorkFlowOnCancelCompanyActivitiesForApprovalCode, RunWorkFlowOnSendCompanyActivitiesForApprovalCode);

            WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkFlowOnSendLeaveApplicationForApprovalCode);
                    WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkFlowOnSendPayrollForApprovalCode);

                    WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkFlowOnSendEmployeeRequisitionForApprovalCode);
                    WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkFlowOnSendTrainingApplicationForApprovalCode);
                    WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkFlowOnSendTrainingNeedsForApprovalCode);
                    WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkFlowOnSendExitInterviewsForApprovalCode);
                    WorkFlowEventHandling.AddEventPredecessor(WorkFlowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkFlowOnSendCompanyActivitiesForApprovalCode);

                end;

        end
    end;

}