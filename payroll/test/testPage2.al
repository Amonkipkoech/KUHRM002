page 50943 "UpdateData"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = update;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(payrollNo; Rec.payrollNo)
                {
                    ApplicationArea = All;
                }
                field(name; Rec.name)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    updatePRLD();
                end;
            }
            action(ActionName2)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    checkNssf();

                end;
            }
            action(ActionName3)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    upDateDepartment();

                end;
            }
            action(ActionName4)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    updatePRLD2();

                end;
            }
            action(ActionName5)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    updatePeriodTrans();

                end;
            }
        }
    }
    var
        empDed: Record "PRL-Employer Deductions";
        hrEmp: Record "HRM-Employee (D)";
        prlPeriodTrans: Record "PRL-Period Transactions";
        trasncode: Record "PRL-Transaction Codes";

    procedure updatePRLD()
    begin
        empDed.Reset();
        empDed.SetRange("Period Year", 2023);
        if empDed.Find('-') then begin
            repeat

                hrEmp.Reset();
                hrEmp.SetRange("No.", empDed."Employee Code");
                if hrEmp.Find('-') then begin
                    empDed."Department Code" := hrEmp."Department Code";
                    empDed.Modify();
                end;


            until empDed.Next() = 0
        end;
    end;

    procedure updatePRLD2()
    begin
        prlPeriodTrans.Reset();
        prlPeriodTrans.SetRange("Period Year", 2023);
        prlPeriodTrans.SetFilter("Transaction Code", '%1|%2', 'E1014', 'E1007');

        if prlPeriodTrans.Find('-') then begin
            repeat
                hrEmp.Reset();
                hrEmp.SetRange("No.", prlPeriodTrans."Employee Code");
                if hrEmp.Find('-') then begin
                    prlPeriodTrans."Department Code" := hrEmp."Department Code";
                    prlPeriodTrans.Modify();
                end;


            until prlPeriodTrans.Next() = 0
        end;
    end;


    procedure checkNssf()
    begin
        empDed.Reset();
        empDed.SetRange("Period Year", 2023);
        empDed.SetRange("Period Month", 1);
        empDed.SetRange("Transaction Code", 'NSSF');
        IF empDed.Find('-') then begin
            empDed.CalcSums(Amount);

            //Message('%1|%2', 'amoun', amou);
        end;

    end;

    procedure upDateDepartment()
    begin
        hrEmp.Reset();
        hrEmp.SetRange("Posting Group", 'PAYROLL');
        if hrEmp.Find('-') then begin
            repeat
                if hrEmp."Department Code" = '' then begin
                    hrEmp."Department Code" := 'DEFAULT';
                    hrEmp.Modify();
                end;
            until hrEmp.Next() = 0;

        end;

    end;

    procedure updatePeriodTrans()
    begin
        prlPeriodTrans.Reset();
        prlPeriodTrans.SetRange("Transaction Code", 'NSSF');
        prlPeriodTrans.SetRange("Period Year", 2023);
        prlPeriodTrans.SetRange("Period Month", 1);
        if prlPeriodTrans.Find('-') then begin
            repeat
                trasncode.Reset();
                trasncode.SetRange("Transaction Code", prlPeriodTrans."Transaction Code");
                if trasncode.Find('-') then begin
                    prlPeriodTrans."Journal Account Code" := trasncode."GL Account";
                    prlPeriodTrans.Modify();
                end;
            until prlPeriodTrans.Next() = 0;
        end;
    end;

}