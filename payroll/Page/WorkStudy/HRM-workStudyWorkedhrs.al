page 85538 "PRL-WorkStudy Worked Hours"
{
    PageType = ListPart;
    Editable = true;
    SourceTable = "PRL Workstudy Hours Worked";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = all;

                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = all;

                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = all;

                }
                field("Computed Hours"; Rec."Computed Hours")
                {
                    Editable = false;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("F.  Name"; Rec."F.  Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("M. Name"; Rec."M. Name")
                {
                    ApplicationArea = all;
                }
                field("L. Name"; Rec."L. Name")
                {
                    ApplicationArea = all;
                }
                field("Current Instalment"; Rec."Current Instalment")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Compute Worked Hours")
            {
                ApplicationArea = all;
                Image = CalculateSalesTax;



                trigger OnAction()
                begin
                    if Confirm('Update the list with Casual employees?', true) = true then begin
                        HRMEmployeeD.Reset;
                        HRMEmployeeD.SetFilter(HRMEmployeeD."Employee Category", '%1|%2', 'CASUAL', 'CASUALS');
                        if HRMEmployeeD.Find('-') then begin
                            repeat
                            begin
                                PRLEmployeeHoursWorked.Reset;
                                PRLEmployeeHoursWorked.SetRange(PRLEmployeeHoursWorked."Employee Code", HRMEmployeeD."No.");
                                if not PRLEmployeeHoursWorked.Find('-') then begin
                                    PRLPayrollPeriods.Reset;
                                    PRLPayrollPeriods.SetFilter(PRLPayrollPeriods.Closed, '=%1', false);
                                    //          PRLPayrollPeriods.SETFILTER("Payroll Code",'%1|%2','CASUAL','CASUALS');
                                    if PRLPayrollPeriods.Find('-') then begin
                                        PRLEmployeeHoursWorked.Init;
                                        PRLEmployeeHoursWorked."Employee Code" := HRMEmployeeD."No.";
                                        PRLEmployeeHoursWorked."F.  Name" := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
                                        PRLEmployeeHoursWorked."Payroll Period" := PRLPayrollPeriods."Date Openned";
                                        PRLEmployeeHoursWorked."Period Month" := PRLPayrollPeriods."Period Month";
                                        PRLEmployeeHoursWorked."Period Year" := PRLPayrollPeriods."Period Year";
                                        PRLEmployeeHoursWorked."Current Instalment" := PRLPayrollPeriods."Current Instalment";
                                        PRLEmployeeHoursWorked.Insert;
                                        PRLEmployeeHoursWorked.Validate("Hours Worked");
                                    end;
                                end;
                            end;
                            until HRMEmployeeD.Next = 0;
                        end;
                    end;
                    PRLEmployeeHoursWorked.Reset;
                    if PRLEmployeeHoursWorked.Find('-') then begin
                        repeat
                        begin
                            PRLEmployeeHoursWorked.Validate("Hours Worked");
                            PRLEmployeeHoursWorked.Modify;
                        end;
                        until PRLEmployeeHoursWorked.Next = 0;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        PRLPayrollPeriods.Reset;
        PRLPayrollPeriods.SetRange(Closed, false);
        if PRLPayrollPeriods.Find('-') then begin
            Rec.SetFilter("Current Instalment", Format(PRLPayrollPeriods."Current Instalment"));
            Rec.SetFilter("Payroll Period", Format(PRLPayrollPeriods."Date Openned"));
        end;
    end;

    var
        PRLEmployeeHoursWorked: Record "PRL Workstudy Hours Worked";
        HRMEmployeeD: Record "HRM-Employee (D)";
        PRLPayrollPeriods: Record "PRL-Casual Payroll Periods";
}

