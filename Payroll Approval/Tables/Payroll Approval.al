table 61841 "Prl-Approval"
{
    LookupPageId = "Prl-Approval List";
    DrillDownPageId = "Prl-Approval List";
    fields
    {
        field(1; "Payroll Period"; Date)
        {
            TableRelation = "PRL-Payroll Periods"."Date Opened" where(Closed = filter(false));
            trigger OnValidate()
            begin
                objPeriod.Reset();
                objPeriod.SetRange("Date Opened", Rec."Payroll Period");
                if objPeriod.Find('-') then begin
                    "Period Month" := objPeriod."Period Month";
                    "Period Year" := objPeriod."Period Year";
                    "Period Name" := objPeriod."Period Name";
                end;
            end;
        }
        field(2; "Period Month"; integer)
        {
            Editable = false;
        }
        field(3; "Period Year"; integer)
        {
            Editable = false;
        }
        field(4; "Period Name"; Text[50])
        {
            Editable = false;

        }
        field(5; Status; Option)
        {
            OptionMembers = " ",Pending,"Pending Approval",Approved,Cancelled,Rejected;
        }
        field(6; "Net Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("PRL-Period Transactions".Amount where("Payroll Period" = field("Payroll Period"),
            "Transaction Code" = filter('NPAY')));
        }
        field(7; "Gross Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("PRL-Period Transactions".Amount where("Payroll Period" = field("Payroll Period"),
            "Transaction Code" = filter('GPAY')));
        }
        field(8; "Total deductions"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("PRL-Period Transactions".Amount where("Payroll Period" = field("Payroll Period"),
            "Group Text" = filter('DEDUCTIONS')));
        }
        field(9; "Approval Comment1"; text[200])
        {

        }
        field(10; "Approval Comment2"; text[200])
        {

        }
        field(11; "Approval Comment3"; text[200])
        {

        }
        field(12; "Approval Comment4"; text[200])
        {

        }

    }

    var
        objPeriod: Record "PRL-Payroll Periods";


    procedure ApprovePayroll()
    begin
        objPeriod.Reset();
        objPeriod.SetRange("Date Opened", Rec."Payroll Period");
        objPeriod.SetRange(Closed, false);
        if objPeriod.Find('-') then begin
            objPeriod."Approved For Closure" := true;
            objPeriod.Modify(true);
        end;
    end;



}