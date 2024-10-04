page 75020 "HRM-Appraisal Periods List"
{
    Editable = true;
    PageType = List;
    SourceTable = "HRM-Appraisal Periods";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                field("Date openned"; Rec."Date openned")
                {
                    ApplicationArea = All;
                }
                field("Date Closed"; Rec."Date Closed")
                {
                    ApplicationArea = All;
                }
                field("Openned By"; Rec."Openned By")
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
        area(creation)
        {
            action("Close/Get Period")
            {
                Caption = 'Close/Get Period';
                Image = Aging;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Close Period?', FALSE) = FALSE THEN ERROR('Closure Cancelled');
                    IF NOT (UserSetup.GET(USERID)) THEN ERROR('Invalid user..');
                    //UserSetup.TESTFIELD("Can Post Customer Refund");
                    //UserSetup.TESTFIELD("Can Post Cust. Deposits");
                    /////////////////////////////////////////////////////////////////////////////////////////////
                    HRMAppraisalPeriods.RESET;
                    HRMAppraisalPeriods.SETFILTER(Closed, '%1', FALSE);
                    IF HRMAppraisalPeriods.FIND('-') THEN BEGIN
                        HRMAppraisalPeriods.Closed := TRUE;
                        HRMAppraisalPeriods."Closed By" := USERID;
                        HRMAppraisalPeriods."Date Closed" := TODAY;
                    END;
                    /////////////////////////////////////////////////////////////////////////////////////////////

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
                            END;
                        END;
                        UNTIL HRMEmployeeC.NEXT = 0;
                    END;

                    MESSAGE('Variables updated successfully');
                end;
            }
            action(PeriodSets)
            {
                Caption = 'Period Sets';
                Image = Period;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 61693;
                ApplicationArea = All;
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
                            END;
                        END;
                        UNTIL HRMEmployeeC.NEXT = 0;
                    END;

                    MESSAGE('Variables updated successfully');
                end;
            }
        }
    }

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

