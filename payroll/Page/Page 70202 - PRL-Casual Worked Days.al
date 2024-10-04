page 70202 "PRL-Casual Worked Days"
{
    PageType = ListPart;
    Editable = true;
    SourceTable = "PRL Employee Days Worked";

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
                field("Days Worked"; Rec."Days Worked")
                {
                    ApplicationArea = all;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = all;
                }
                field("Computed Days"; Rec."Computed Days")
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
            action("Compute Worked Days")
            {
                ApplicationArea = all;
                Caption = 'Compute Worked Days';
                Image = CalculateSalesTax;



                trigger OnAction()
                begin
                    if Confirm('Update the list with Casual employees?', true) = true then begin
                        HRMEmployeeD.Reset;
                        HRMEmployeeD.SetFilter(HRMEmployeeD."Employee Category", '%1|%2', 'CASUAL', 'CASUALS');
                        if HRMEmployeeD.Find('-') then begin
                            repeat
                            begin
                                PRLEmployeeDaysWorked.Reset;
                                PRLEmployeeDaysWorked.SetRange(PRLEmployeeDaysWorked."Employee Code", HRMEmployeeD."No.");
                                if not PRLEmployeeDaysWorked.Find('-') then begin
                                    PRLPayrollPeriods.Reset;
                                    PRLPayrollPeriods.SetFilter(PRLPayrollPeriods.Closed, '=%1', false);
                                    //          PRLPayrollPeriods.SETFILTER("Payroll Code",'%1|%2','CASUAL','CASUALS');
                                    if PRLPayrollPeriods.Find('-') then begin
                                        PRLEmployeeDaysWorked.Init;
                                        PRLEmployeeDaysWorked."Employee Code" := HRMEmployeeD."No.";
                                        PRLEmployeeDaysWorked."F.  Name" := HRMEmployeeD."First Name" + ' ' + HRMEmployeeD."Middle Name" + ' ' + HRMEmployeeD."Last Name";
                                        PRLEmployeeDaysWorked."Payroll Period" := PRLPayrollPeriods."Date Openned";
                                        PRLEmployeeDaysWorked."Period Month" := PRLPayrollPeriods."Period Month";
                                        PRLEmployeeDaysWorked."Period Year" := PRLPayrollPeriods."Period Year";
                                        PRLEmployeeDaysWorked."Current Instalment" := PRLPayrollPeriods."Current Instalment";
                                        PRLEmployeeDaysWorked.Insert;
                                        PRLEmployeeDaysWorked.Validate("Days Worked");
                                    end;
                                end;
                            end;
                            until HRMEmployeeD.Next = 0;
                        end;
                    end;
                    PRLEmployeeDaysWorked.Reset;
                    if PRLEmployeeDaysWorked.Find('-') then begin
                        repeat
                        begin
                            PRLEmployeeDaysWorked.Validate("Days Worked");
                            PRLEmployeeDaysWorked.Modify;
                        end;
                        until PRLEmployeeDaysWorked.Next = 0;
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
        PRLEmployeeDaysWorked: Record "PRL Employee Days Worked";
        HRMEmployeeD: Record "HRM-Employee (D)";
        PRLPayrollPeriods: Record "PRL-Casual Payroll Periods";
}

