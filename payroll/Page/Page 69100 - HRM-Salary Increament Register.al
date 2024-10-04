page 69100 "HRM-Salary Increament Register"
{
    Editable = false;
    PageType = List;
    SourceTable = "HRM-Salary Increament Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field(names; names)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Name';
                }
                field("Increament Month"; Rec."Increament Month")
                {
                    ApplicationArea = all;
                }
                field("Increament Year"; Rec."Increament Year")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Prev. Salary"; Rec."Prev. Salary")
                {
                    ApplicationArea = all;
                }
                field("Current Salary"; Rec."Current Salary")
                {
                    ApplicationArea = all;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = all;
                }
                field("Job Category"; Rec."Job Category")
                {
                    ApplicationArea = all;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = all;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnInit()
    begin
        Clear(names);
        if emps.Get(Rec."Employee No.") then
            names := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
    end;

    trigger OnOpenPage()
    begin
        //Clear(names);
        if emps.Get(Rec."Employee No.") then
            names := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        Clear(names);
        if emps.Get(Rec."Employee No.") then
            names := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
    end;

    var
        names: Text[250];
        emps: Record "HRM-Employee (D)";
}

