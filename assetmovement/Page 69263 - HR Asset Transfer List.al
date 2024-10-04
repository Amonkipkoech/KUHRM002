page 70029 "HR Asset Transfer List"
{
    Caption = 'Asset Transfer Card';
    //CardPageID = "Hr Asset  Transfer Header";
    DeleteAllowed = false;
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;
    PageType = List;
    SourceTable = "HR Asset Transfer Header";
    SourceTableView = WHERE(Status = FILTER(<> Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Transfered; Rec.Transfered)
                {
                    ApplicationArea = All;
                }
                field("Date Transfered"; Rec."Date Transfered")
                {
                    ApplicationArea = All;
                }
                field("Transfered By"; Rec."Transfered By")
                {
                    ApplicationArea = All;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing){
            action(nem){
                trigger OnAction()
                var
                peg : page "Purch. Invoice Subform";
                begin

                end;
            }
        }
    }
}

