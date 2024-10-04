page 75005 "HRM-Appraisal Years List"
{
    CardPageID = "HRM-Appraisal Years Card";
    PageType = List;
    SourceTable = "HRM-Appraisal Years";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                Image = ReferenceData;
                action(AppraisalSetups)
                {
                    Caption = 'Appraisal Setups';
                    Image = AnalysisView;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Gen. Setup";
                    ApplicationArea = All;
                }
                action(AppraisalPeriods)
                {
                    Caption = 'Appraisal Periods';
                    Image = ClosePeriod;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Periods List";
                    RunPageLink = "Appraisal Year Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action(AppraisalSummaryLabels)
                {
                    Caption = 'Appraisal Summary Labels';
                    Image = SuggestCapacity;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Recomm List";
                    RunPageLink = "Appraisal Year Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action(Jobs)
                {
                    Caption = 'Appraisal Jobs';
                    Image = JobListSetup;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HRM-Appraisal Jobs List";
                    RunPageLink = "Appraisal Year Code" = FIELD(Code);
                    ApplicationArea = All;
                }
                action("Period Sets")
                {
                    Caption = 'Period Sets';
                    Image = Apply;
                    Promoted = true;
                    RunObject = Page "HRM-Appraisal Period Sets";
                    ApplicationArea = All;
                }
            }
            group(Process)
            {
                Caption = 'Process';
                Image = ProductDesign;
                action(ComputeYearlyScores)
                {
                    Caption = 'Compute Yearly Scores';
                    Image = CalculateSimulation;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // Compute Yearly Averages
                    end;
                }
                action("Update Static Data")
                {
                    Caption = 'Update Static Data';
                    Image = Aging;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT (UserSetup.GET(USERID)) THEN ERROR('Invalid user..');
                        //UserSetup.TESTFIELD("Can Post Customer Refund");
                        IF CONFIRM('This will get all current Parameters Includig:\- Current Standard target\- Job Positions to be Appraised in the Current Period\'
                          + '- Employee Appraisal Registration, etc', TRUE) = FALSE THEN
                            ERROR('Cancelled!');
                        CLEAR(founds);
                        HRMAppraisalYears.RESET;
                        HRMAppraisalYears.SETRANGE(Closed, FALSE);
                        HRMAppraisalYears.SETFILTER(Code, '<>%1', '');
                        IF NOT HRMAppraisalYears.FIND('-') THEN ERROR('There is no open Appraisal Year in the Filter');
                        HRMAppraisalPeriods.RESET;
                        HRMAppraisalPeriods.SETRANGE("Appraisal Year Code", HRMAppraisalYears.Code);
                        HRMAppraisalPeriods.SETFILTER(Closed, '<>%1', TRUE);
                        IF NOT HRMAppraisalPeriods.FIND('-') THEN BEGIN
                            //Create a Period for the year from the Sets
                            HRMAppraisalPeriodsSet.RESET;
                            HRMAppraisalPeriodsSet.SETFILTER("Period Code", '<>%1', '');
                            IF NOT HRMAppraisalPeriodsSet.FINDFIRST THEN ERROR('No Appraisal Periods setup');
                            REPEAT
                            BEGIN
                                HRMAppraisalPeriods.RESET;
                                HRMAppraisalPeriods.SETRANGE("Appraisal Year Code", HRMAppraisalYears.Code);
                                HRMAppraisalPeriods.SETRANGE(Code, HRMAppraisalPeriodsSet."Period Code");
                                IF NOT HRMAppraisalPeriods.FIND('-') THEN BEGIN
                                    founds := TRUE;
                                    HRMAppraisalPeriods.INIT;
                                    HRMAppraisalPeriods.Code := HRMAppraisalPeriodsSet."Period Code";
                                    HRMAppraisalPeriods."Appraisal Year Code" := HRMAppraisalYears.Code;
                                    HRMAppraisalPeriods.Description := HRMAppraisalPeriodsSet."Period Description";
                                    HRMAppraisalPeriods."Date openned" := TODAY;
                                    HRMAppraisalPeriods."Openned By" := USERID;
                                    HRMAppraisalPeriods.INSERT;
                                END;
                            END;
                            UNTIL ((HRMAppraisalPeriodsSet.NEXT = 0) OR (founds))

                        END;


                        HRMAppraisalPeriods.RESET;
                        HRMAppraisalPeriods.SETRANGE("Appraisal Year Code", HRMAppraisalYears.Code);
                        HRMAppraisalPeriods.SETFILTER(Closed, '<>%1', TRUE);
                        IF NOT HRMAppraisalPeriods.FIND('-') THEN ERROR('There are no open Periods for: ' + HRMAppraisalYears.Code);

                        HRMJobs.RESET;
                        IF HRMJobs.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                AppJobs.RESET;
                                AppJobs.SETRANGE(Code, HRMJobs."Job ID");
                                AppJobs.SETRANGE("Appraisal Year Code", HRMAppraisalYears.Code);
                                IF NOT AppJobs.FIND('-') THEN BEGIN
                                    AppJobs.INIT;
                                    AppJobs.Code := HRMJobs."Job ID";
                                    AppJobs."Appraisal Year Code" := HRMAppraisalYears.Code;
                                    AppJobs.Description := HRMJobs."Job Title";
                                    AppJobs.INSERT;
                                END;
                                // Populate Targets
                                HRMJobAppraisalTargetSetup.RESET;
                                HRMJobAppraisalTargetSetup.SETRANGE("Job Id", HRMJobs."Job ID");
                                IF HRMJobAppraisalTargetSetup.FIND('-') THEN BEGIN
                                    REPEAT
                                    BEGIN
                                        HRMAppraisalTargets.RESET;
                                        HRMAppraisalTargets.SETRANGE("Appraisal Job Code", HRMJobAppraisalTargetSetup."Job Id");
                                        HRMAppraisalTargets.SETRANGE("Appraisal Year Code", HRMAppraisalYears.Code);
                                        HRMAppraisalTargets.SETRANGE(Code, HRMJobAppraisalTargetSetup."Target Code");
                                        IF NOT HRMAppraisalTargets.FIND('-') THEN BEGIN
                                            HRMAppraisalTargets.INIT;
                                            HRMAppraisalTargets."Appraisal Job Code" := HRMJobs."Job ID";
                                            HRMAppraisalTargets."Appraisal Year Code" := HRMAppraisalYears.Code;
                                            HRMAppraisalTargets.Code := HRMJobAppraisalTargetSetup."Target Code";
                                            HRMAppraisalTargets.Desription := HRMJobAppraisalTargetSetup."Target Description";
                                            HRMAppraisalTargets."Job Title" := HRMJobs."Job Title";
                                            HRMAppraisalTargets.INSERT;
                                        END;
                                    END;
                                    UNTIL HRMJobAppraisalTargetSetup.NEXT = 0;
                                END;
                            END;
                            UNTIL HRMJobs.NEXT = 0;
                        END;

                        HRMEmployeeC.RESET;
                        HRMEmployeeC.SETRANGE(HRMEmployeeC.Status, HRMEmployeeC.Status::Active);
                        IF HRMEmployeeC.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                HRMAppraisalRegistration.RESET;
                                HRMAppraisalRegistration.SETRANGE("PF No.", HRMEmployeeC."No.");
                                HRMAppraisalRegistration.SETRANGE("Appraisal Period Code", HRMAppraisalPeriods.Code);
                                HRMAppraisalRegistration.SETRANGE("Appraisal Job Code", HRMEmployeeC."Job Title");
                                HRMAppraisalRegistration.SETRANGE("Appraisal Year Code", HRMAppraisalYears.Code);
                                IF NOT HRMAppraisalRegistration.FINDFIRST THEN BEGIN
                                    HRMAppraisalRegistration.INIT;
                                    HRMAppraisalRegistration."PF No." := HRMEmployeeC."No.";
                                    HRMAppraisalRegistration."Appraisal Period Code" := HRMAppraisalPeriods.Code;
                                    HRMAppraisalRegistration."Appraisal Job Code" := HRMEmployeeC."Job Title";
                                    HRMAppraisalRegistration."Appraisal Year Code" := HRMAppraisalYears.Code;
                                    HRMAppraisalRegistration."`" := USERID;
                                    HRMAppraisalRegistration."Registration Date" := TODAY;
                                    HRMAppraisalRegistration."Reg. Transacton ID" := '';
                                    HRMAppraisalRegistration."Date Registered" := TODAY;
                                    HRMAppraisalRegistration.INSERT(TRUE);
                                END;
                                //Register Employees for Periodic Appraisal
                                HRMJobs.RESET;
                                HRMJobs.SETRANGE("Job ID", HRMEmployeeC."Job Title");
                                IF HRMJobs.FIND('-') THEN BEGIN
                                    HRMAppraisalTargets.RESET;
                                    HRMAppraisalTargets.SETRANGE("Appraisal Job Code", HRMJobs."Job ID");
                                    HRMAppraisalTargets.SETRANGE("Appraisal Year Code", HRMAppraisalYears.Code);
                                    IF HRMAppraisalTargets.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            HRMAppraisalEmpTargets.RESET;
                                            HRMAppraisalEmpTargets.SETRANGE("PF. No.", HRMEmployeeC."No.");
                                            HRMAppraisalEmpTargets.SETRANGE("Appraisal Period Code", HRMAppraisalPeriods.Code);
                                            HRMAppraisalEmpTargets.SETRANGE("Appraisal Job Code", HRMEmployeeC."Job Title");
                                            HRMAppraisalEmpTargets.SETRANGE("Appraisal year Code", HRMAppraisalYears.Code);
                                            HRMAppraisalEmpTargets.SETRANGE("Appraisal Target Code", HRMAppraisalTargets.Code);
                                            IF NOT HRMAppraisalEmpTargets.FINDFIRST THEN BEGIN
                                                HRMAppraisalEmpTargets.INIT;
                                                HRMAppraisalEmpTargets."Appraisal Job Code" := HRMJobs."Job ID";
                                                HRMAppraisalEmpTargets."Appraisal Period Code" := HRMAppraisalPeriods.Code;
                                                HRMAppraisalEmpTargets."Appraisal Target Code" := HRMAppraisalTargets.Code;
                                                HRMAppraisalEmpTargets."Appraisal year Code" := HRMAppraisalYears.Code;
                                                HRMAppraisalEmpTargets."PF. No." := HRMEmployeeC."No.";
                                                HRMAppraisalEmpTargets.INSERT;
                                            END;
                                        END;
                                        UNTIL HRMAppraisalTargets.NEXT = 0;
                                    END;
                                END;
                            END;
                            UNTIL HRMEmployeeC.NEXT = 0;
                        END;

                        MESSAGE('Variables updated successfully');
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    var
        AppJobs: Record "HRM-Appraisal Jobs";
        HRMAppraisalPeriods: Record "HRM-Appraisal Periods";
        HRMJobs: Record "HRM-Jobs";
        HRMAppraisalEmpTargets: Record "HRM-Appraisal Emp. Targets";
        HRMJobAppraisalTargetSetup: Record "HRM-Job Appraisal Target Setup";
        HRMAppraisalRegistration: Record "HRM-Appraisal Registration";
        HRMAppraisalYears: Record "HRM-Appraisal Years";
        HRMAppraisalPeriodsSet: Record "HRM-Appraisal Periods Set";
        founds: Boolean;
        HRMAppraisalTargets: Record "HRM-Appraisal Targets";
        HRMEmployeeC: Record "HRM-Employee (D)";
        UserSetup: Record 91;
}

