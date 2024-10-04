page 68148 "HRM-Activity Employess"
{
    PageType = Worksheet;
    SourceTable = "HRM-Activity Employees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Emp.Reset;
                        Emp.SetRange(Emp."No.", Rec."Employee No");
                        if Emp.Find('-') then begin
                            Rec."Full Names" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name"
                        end;
                    end;
                }
                field("Full Names"; Rec."Full Names")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Emp: Record "HRM-Employee (D)";
}

