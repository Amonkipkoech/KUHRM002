page 68084 "PRL-Salary Arrears (B)"
{
    PageType = Card;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("""First Name""+' '+""Middle Name""+' '+""Last Name"""; Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name")
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                    ApplicationArea = All;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    TableRelation = "PRL-Payroll Periods"."Date Opened";
                    ApplicationArea = All;
                }
                field(ProcessAll; ProcessAll)
                {
                    Caption = 'All Employees';
                    ApplicationArea = All;
                }
            }
            part(Control1102756010; "PRL-Salary Arrears (C)")
            {
                SubPageLink = "Employee Code" = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Process Arrears")
                {
                    Caption = 'Process Arrears';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Get the Salary Arrears code
                        TransCode.SetRange(TransCode."Special Transactions", 6);
                        if TransCode.Find('-') then
                            strTransCode := TransCode."Transaction Code";

                        //Get the open/current period
                        PayPeriod.SetRange(PayPeriod.Closed, false);
                        if PayPeriod.Find('-') then begin
                            PeriodMonth := PayPeriod."Period Month";
                            PeriodYear := PayPeriod."Period Year";
                        end;

                        if ProcessAll then begin
                            HrEmployee.Reset;
                            HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                            if HrEmployee.Find('-') then begin
                                repeat
                                    //Get the staff current salary
                                    if SalCard.Get(HrEmployee."No.") then begin
                                        CurrBasic := SalCard."Basic Pay";
                                    end;
                                    objOcx.fnSalaryArrears(HrEmployee."No.", strTransCode, CurrBasic, StartDate, EndDate, PayPeriod."Date Opened",
                                    HrEmployee."Date Of Join", HrEmployee."Date Of Leaving");
                                until HrEmployee.Next = 0;
                            end;
                        end else begin
                            //Get the staff current salary
                            if SalCard.Get(Rec."No.") then begin
                                CurrBasic := SalCard."Basic Pay";
                            end;

                            objOcx.fnSalaryArrears(Rec."No.", strTransCode, CurrBasic, StartDate, EndDate, PayPeriod."Date Opened",
                            Rec."Date Of Join", Rec."Date Of Leaving");

                        end;
                    end;
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ProcessAll: Boolean;
        HrEmployee: Record "HRM-Employee (D)";
        objOcx: Codeunit prPayrollProcessing;
        SalCard: Record "PRL-Salary Card";
        PayPeriod: Record "PRL-Payroll Periods";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        TransCode: Record "PRL-Transaction Codes";
        strTransCode: Text[30];
        strEmpCode: Text[30];
        SalArr: Record "PRL-Salary Arrears";
        strEmpName: Text[50];
        objEmp: Record "HRM-Employee (D)";
        CurrBasic: Decimal;
}

