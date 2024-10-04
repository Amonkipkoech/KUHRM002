page 68339 "HRM-Job Resp. Lines"
{
    CardPageID = "HRM-Job Responsibilities";
    PageType = ListPart;
    SourceTable = "HRM-Job Responsiblities (B)";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Job ID";Rec."Job ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    
                }
                field("Job Reference N.o";Rec."Job Reference N.o")
                {
                    ApplicationArea = All;
                    Visible = false;
                    
                }
                field("Responsibility Code"; Rec."Responsibility Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Responsibility Description"; Rec."Responsibility Description")
                {
                    ApplicationArea = all;
                    Caption = 'Resposibilities';
                    MultiLine = True;
                  
                }
                field("Minimun Requirement";Rec."Minimun Requirement")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Resposibility two";Rec."Resposibility two")
                {
                        ApplicationArea =  all;
                        Caption = 'Responsibilities Two';
                        Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

