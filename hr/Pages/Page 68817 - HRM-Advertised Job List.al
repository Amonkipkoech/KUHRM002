page 68817 "HRM-Advertised Job List"
{
    CardPageID = "HRM-Advertised Job Card";
    PageType = List;
    SourceTable = "HRM-Employee Requisitions";
    SourceTableView = WHERE(Advertised = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = all;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = all;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = all;
                }
                field(Positions; Rec.Positions)
                {
                    ApplicationArea = all;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = all;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = all;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = all;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = all;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = all;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = all;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = all;
                }
                field("Job Supervisor/Manager"; Rec."Job Supervisor/Manager")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                    ApplicationArea = all;
                }
                field("Grace Period"; Rec."Grace Period")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = all;
                }
                field("Closing Date"; Rec."Closing Date")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = all;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = all;
                }
                field("Reason for Request(Other)"; Rec."Reason for Request(Other)")
                {
                    ApplicationArea = all;
                }
                field("Any Additional Information"; Rec."Any Additional Information")
                {
                    ApplicationArea = all;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = all;
                }
                field("Type of Contract Required"; Rec."Type of Contract Required")
                {
                    ApplicationArea = all;
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                }
                field("Job Ref No"; Rec."Job Ref No")
                {
                    ApplicationArea = all;
                }
                field(Advertised; Rec.Advertised)
                {
                    ApplicationArea = all;
                }
                field("Opening Date"; Rec."Opening Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

