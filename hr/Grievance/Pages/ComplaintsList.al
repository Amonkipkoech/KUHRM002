page 50002 "Complaints List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 50001;
    CardPageId = 50001;

    layout
    {
        area(Content)
        {
            repeater(Complaints)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("PF No"; Rec."PF No")
                {
                    ApplicationArea = All;
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = All;
                }
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = All;
                }
                field(Dim2; Rec.Dim2)
                {
                    Caption = 'Region Name';
                    ApplicationArea = All;
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ApplicationArea = All;
                    //ApplicationArea = All;
                }
                field(Dim1; Rec.Dim1)
                {
                    Caption = 'Region Name';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    //DataClassification = ToBeClassified;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}