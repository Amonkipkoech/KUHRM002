codeunit  50005 "Workflow Setup Ext(hr)"
{

    trigger OnRun()
    begin

    end;

    var
        workflowSetup: Codeunit 1502;

        //leave
        LeaveApplicationWorkflowCategoryTxt: TextConst ENU = 'Leave';
        LeaveApplicationWorkflowCategoryDescTxt: TextConst ENU = 'Leave Application Document';
        LeaveApplicationApprovalWorkflowCodeTxt: TextConst ENU = 'Leave';
        LeaveApplicationApprovalWorkfowDescTxt: TextConst ENU = 'Leave Application Approval Workflow';

        //Payroll
        PayrollWorkflowCategoryTxt: TextConst ENU = 'PAYROLL';
        PayrollWorkflowCategoryDescTxt: TextConst ENU = 'Payroll  Document';
        PayrollApprovalWorkflowCodeTxt: TextConst ENU = 'Payroll';
        PayrollApprovalWorkfowDescTxt: TextConst ENU = 'Payroll Approval Workflow';

        //employee requisition
        EmployeeRequisitionWorkflowCategoryTxt: TextConst ENU = 'Employee Requisition';
        EmployeeRequisitionWorkflowCategoryDescTxt: TextConst ENU = 'Employee Requisition  Document';
        EmployeeRequisitionApprovalWorkflowCodeTxt: TextConst ENU = 'Employee Requisition';
        EmployeeRequisitionApprovalWorkfowDescTxt: TextConst ENU = 'Employee Requisition Approval Workflow';

        //Training Application
        TrainingApplicationWorkflowCategoryTxt: TextConst ENU = 'Training Application';
        TrainingApplicationWorkflowCategoryDescTxt: TextConst ENU = 'Training Application  Document';
        TrainingApplicationApprovalWorkflowCodeTxt: TextConst ENU = 'Training Application';
        TrainingApplicationApprovalWorkfowDescTxt: TextConst ENU = 'Training Application Approval Workflow';
        //Training Needs
        TrainingNeedsWorkflowCategoryTxt: TextConst ENU = 'Training Needs';
        TrainingNeedsWorkflowCategoryDescTxt: TextConst ENU = 'Training Needs  Document';
        TrainingNeedsApprovalWorkflowCodeTxt: TextConst ENU = 'Training Needs';
        TrainingNeedsApprovalWorkfowDescTxt: TextConst ENU = 'Training Needs Approval Workflow';

        //Exit Interviews
        ExitInterviewsWorkflowCategoryTxt: TextConst ENU = 'Exit Interviews';
        ExitInterviewsWorkflowCategoryDescTxt: TextConst ENU = 'Exit Interviews  Document';
        ExitInterviewsApprovalWorkflowCodeTxt: TextConst ENU = 'Exit Interviews';
        ExitInterviewsApprovalWorkfowDescTxt: TextConst ENU = 'Exit Interviews Approval Workflow';

        //Payroll
        CompanyActivitiesWorkflowCategoryTxt: TextConst ENU = 'Company Activities';
        CompanyActivitiesWorkflowCategoryDescTxt: TextConst ENU = 'Company Activities';
        CompanyActivitiesApprovalWorkflowCodeTxt: TextConst ENU = 'Company Activities';
        CompanyActivitiesApprovalWorkfowDescTxt: TextConst ENU = 'Company Activities Approval Workflow';


        //type condition report text
        LeaveApplicationTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="FIN-Payments Header">%1</DataItem></DataItems></ReportParameters>';
        PayrollTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="PRL-Payroll Periods">%1</DataItem></DataItems></ReportParameters>';
        EmployeeRequisitionTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="HRM-Employee Requisitions">%1</DataItem></DataItems></ReportParameters>';

        TrainingApplicationTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="HRM-Training Applications">%1</DataItem></DataItems></ReportParameters>';
        TrainingNeedsTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="HRM-Training Needs Analysis">%1</DataItem></DataItems></ReportParameters>';

        ExitInterviewsTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="HRM-Employee Exit Interviews">%1</DataItem></DataItems></ReportParameters>';

        CompanyActivitiesTypeCondTxt: TextConst ENU = '<?xml version = “1.0” encoding=”utf-8” standalone=”yes”?><ReportParameters><DataItems><DataItem name="HRM-Company Activities">%1</DataItem></DataItems></ReportParameters>';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddWorkflowCategoriesToLibrary', '', true, true)]
    local procedure OnAddWorkflowCategoriesToLibrary()
    begin
        workflowSetup.InsertWorkflowCategory(LeaveApplicationWorkflowCategoryTxt, LeaveApplicationWorkflowCategoryDescTxt);
        workflowSetup.InsertWorkflowCategory(PayrollWorkflowCategoryTxt, PayrollWorkflowCategoryDescTxt);

        workflowSetup.InsertWorkflowCategory(EmployeeRequisitionWorkflowCategoryTxt, EmployeeRequisitionWorkflowCategoryDescTxt);
        workflowSetup.InsertWorkflowCategory(TrainingApplicationWorkflowCategoryTxt, TrainingApplicationWorkflowCategoryDescTxt);
        workflowSetup.InsertWorkflowCategory(TrainingNeedsWorkflowCategoryTxt, TrainingNeedsWorkflowCategoryDescTxt);
        workflowSetup.InsertWorkflowCategory(ExitInterviewsWorkflowCategoryTxt, ExitInterviewsWorkflowCategoryDescTxt);
        workflowSetup.InsertWorkflowCategory(CompanyActivitiesWorkflowCategoryTxt, CompanyActivitiesWorkflowCategoryDescTxt);

    end;

    ////////////////////************ADD WORKFLOW TABLE RELATIONS***********************/////////////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAfterInsertApprovalsTableRelations', '', true, true)]
    local procedure OnAfterInsertApprovalTableRelations()
    var
        ApprovalEntry: Record 454;

    begin
        // workflowSetup.InsertTableRelation(Database::"FIN-Payments Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
        workflowSetup.InsertTableRelation(Database::"PRL-Payroll Periods", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnInsertWorkflowTemplates', '', true, true)]
    local procedure OnInsertWorkflowTemplates()
    begin
        InsertApprovalWorkflowTemplate();
    end;

    local procedure InsertApprovalWorkflowTemplate()
    var
        Workflow: Record 1501;
    begin
        InsertApprovalWorkflowDetail(Workflow);
        workflowSetup.MarkWorkflowAsTemplate(Workflow);

        workflowSetup.InsertWorkflowTemplate(Workflow, LeaveApplicationApprovalWorkflowCodeTxt, LeaveApplicationApprovalWorkfowDescTxt, LeaveApplicationWorkflowCategoryTxt);
        workflowSetup.InsertWorkflowTemplate(Workflow, PayrollApprovalWorkflowCodeTxt, PayrollApprovalWorkfowDescTxt, PayrollWorkflowCategoryTxt);
        workflowSetup.InsertWorkflowTemplate(Workflow, EmployeeRequisitionApprovalWorkflowCodeTxt, EmployeeRequisitionApprovalWorkfowDescTxt, EmployeeRequisitionWorkflowCategoryTxt);
        workflowSetup.InsertWorkflowTemplate(Workflow, TrainingApplicationApprovalWorkflowCodeTxt, TrainingApplicationApprovalWorkfowDescTxt, TrainingApplicationWorkflowCategoryTxt);
        workflowSetup.InsertWorkflowTemplate(Workflow, TrainingNeedsApprovalWorkflowCodeTxt, TrainingNeedsApprovalWorkfowDescTxt, TrainingNeedsWorkflowCategoryTxt);
        workflowSetup.InsertWorkflowTemplate(Workflow, ExitInterviewsApprovalWorkflowCodeTxt, ExitInterviewsApprovalWorkfowDescTxt, ExitInterviewsWorkflowCategoryTxt);
        workflowSetup.InsertWorkflowTemplate(Workflow, CompanyActivitiesApprovalWorkflowCodeTxt, CompanyActivitiesApprovalWorkfowDescTxt, CompanyActivitiesWorkflowCategoryTxt);




    end;

    local procedure InsertApprovalWorkflowDetail(var workflow: Record 1501)
    var
        WorkflowStepArgument: Record 1523;
        BlankDateFormula: DateFormula;
        WorkFlowEventHandlingHR: Codeunit "Workflow Event Handling (hr)";
        WorkflowResponseHandling: Codeunit 1521;
        LeaveApplication: Record "HRM-Leave Requisition";
        PayrollHeader: Record "PRL-Payroll Periods";

        EmployeeRequisition: Record "HRM-Employee Requisitions";
        TrainingApplication: Record "HRM-Training Applications";
        TrainingNeeds: Record "HRM-Training Needs Analysis";
        ExitInterview: Record "HRM-Employee Exit Interviews";
        CompanyActivities: Record "HRM-Company Activities";


    begin
        workflowSetup.InitWorkflowStepArgument(WorkflowStepArgument, WorkflowStepArgument."Approver Type"::"Workflow User Group", WorkflowStepArgument."Approver Limit Type"::"Direct Approver",
        0, '', BlankDateFormula, TRUE);
        //leave
        workflowSetup.InsertDocApprovalWorkflowSteps(
            workflow,
         BuildLeaveApplicationTypeConditions(LeaveApplication.Status::Open),
         WorkFlowEventHandlingHR.RunWorkFlowOnSendLeaveApplicationForApprovalCode,
         BuildLeaveApplicationTypeConditions(LeaveApplication.Status::"Pending Approval"),
         WorkFlowEventHandlingHR.RunWorkFlowOnCancelLeaveApplicationForApprovalCode,
         WorkflowStepArgument, TRUE
        );

        //Payroll
        workflowSetup.InsertDocApprovalWorkflowSteps(
                    workflow,
                 BuildPayrollTypeConditions(PayrollHeader.Status::Open),
                 WorkFlowEventHandlingHR.RunWorkFlowOnSendPayrollForApprovalCode,
                 BuildPayrollTypeConditions(PayrollHeader.Status::"Pending Approval"),
                 WorkFlowEventHandlingHR.RunWorkFlowOnCancelPayrollForApprovalCode,
                 WorkflowStepArgument, TRUE
                );

        //Employe req
        workflowSetup.InsertDocApprovalWorkflowSteps(
            workflow,
         BuildEmployeeRequisitionTypeConditions(EmployeeRequisition.Status::New),
         WorkFlowEventHandlingHR.RunWorkFlowOnSendEmployeeRequisitionForApprovalCode,
         BuildEmployeeRequisitionTypeConditions(EmployeeRequisition.Status::"Pending Approval"),
         WorkFlowEventHandlingHR.RunWorkFlowOnCancelEmployeeRequisitionForApprovalCode,
         WorkflowStepArgument, TRUE
        );

        //training Appl
        workflowSetup.InsertDocApprovalWorkflowSteps(
                    workflow,
                 BuildTrainingApplicationTypeConditions(TrainingApplication.Status::New),
                 WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingApplicationForApprovalCode,
                 BuildTrainingApplicationTypeConditions(TrainingApplication.Status::"Pending Approval"),
                 WorkFlowEventHandlingHR.RunWorkFlowOnCancelTrainingApplicationForApprovalCode,
                 WorkflowStepArgument, TRUE
                );
        //training needs
        workflowSetup.InsertDocApprovalWorkflowSteps(
            workflow,
         BuildTrainingNeedsTypeConditions(TrainingNeeds.Status::New),
         WorkFlowEventHandlingHR.RunWorkFlowOnSendTrainingNeedsForApprovalCode,
         BuildTrainingNeedsTypeConditions(TrainingNeeds.Status::"Pending Approval"),
         WorkFlowEventHandlingHR.RunWorkFlowOnCancelTrainingNeedsForApprovalCode,
         WorkflowStepArgument, TRUE
        );

        //Exit interviews
        workflowSetup.InsertDocApprovalWorkflowSteps(
                    workflow,
                 BuildExitInterviewsTypeConditions(ExitInterview.Status::New),
                 WorkFlowEventHandlingHR.RunWorkFlowOnSendExitInterviewsForApprovalCode,
                 BuildExitInterviewsTypeConditions(ExitInterview.Status::"Pending Approval"),
                 WorkFlowEventHandlingHR.RunWorkFlowOnCancelExitInterviewsForApprovalCode,
                 WorkflowStepArgument, TRUE
                );

        //company activities
        workflowSetup.InsertDocApprovalWorkflowSteps(
                    workflow,
                 BuildCompanyActivitiesTypeConditions(CompanyActivities.Status::New),
                 WorkFlowEventHandlingHR.RunWorkFlowOnSendCompanyActivitiesForApprovalCode,
                 BuildCompanyActivitiesTypeConditions(CompanyActivities.Status::"Pending Approval"),
                 WorkFlowEventHandlingHR.RunWorkFlowOnCancelCompanyActivitiesForApprovalCode,
                 WorkflowStepArgument, TRUE
                );

    end;

    ///////////////////////**********************TYPE CONDITIONS***************////////////////
    /// PV
    local procedure BuildLeaveApplicationTypeConditions(Status: Integer): Text
    var
        LeaveApplication: Record "HRM-Leave Requisition";
    begin
        LeaveApplication.SetRange(Status, Status);
        exit(StrSubstNo(LeaveApplicationTypeCondTxt, workflowSetup.Encode(LeaveApplication.GetView(false))))
    end;


    //Payroll
    local procedure BuildPayrollTypeConditions(Status: Integer): Text
    var
        PayrollHeader: Record "PRL-Payroll Periods";
    begin
        PayrollHeader.SetRange(Status, Status);
        exit(StrSubstNo(PayrollTypeCondTxt, workflowSetup.Encode(PayrollHeader.GetView(false))))
    end;

    /// employee req
    local procedure BuildEmployeeRequisitionTypeConditions(Status: Integer): Text
    var
        employeeReq: Record "HRM-Employee Requisitions";
    begin
        employeeReq.SetRange(Status, Status);
        exit(StrSubstNo(EmployeeRequisitionTypeCondTxt, workflowSetup.Encode(employeeReq.GetView(false))))
    end;


    //training appl
    local procedure BuildTrainingApplicationTypeConditions(Status: Integer): Text
    var
        TrainingAppl: Record "HRM-Training Applications";
    begin
        TrainingAppl.SetRange(Status, Status);
        exit(StrSubstNo(TrainingApplicationTypeCondTxt, workflowSetup.Encode(TrainingAppl.GetView(false))))
    end;

    /// training needs
    local procedure BuildTrainingNeedsTypeConditions(Status: Integer): Text
    var
        TrainingNeeds: Record "HRM-Training Needs Analysis";
    begin
        TrainingNeeds.SetRange(Status, Status);
        exit(StrSubstNo(TrainingNeedsTypeCondTxt, workflowSetup.Encode(TrainingNeeds.GetView(false))))
    end;


    //exit interviews
    local procedure BuildExitInterviewsTypeConditions(Status: Integer): Text
    var
        ExitInterviews: Record "HRM-Employee Exit Interviews";
    begin
        ExitInterviews.SetRange(Status, Status);
        exit(StrSubstNo(ExitInterviewsTypeCondTxt, workflowSetup.Encode(ExitInterviews.GetView(false))))
    end;

    //company activities
    local procedure BuildCompanyActivitiesTypeConditions(Status: Integer): Text
    var
        CompanyActivities: Record "HRM-Company Activities";
    begin
        CompanyActivities.SetRange(Status, Status);
        exit(StrSubstNo(CompanyActivitiesTypeCondTxt, workflowSetup.Encode(CompanyActivities.GetView(false))))
    end;

}