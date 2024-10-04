page 68829 "HRM- EMail Parameters"
{
    PageType = Card;
    SourceTable = "HRM-EMail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Associate With"; Rec."Associate With")
                {
                    ApplicationArea = All;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = All;
                }
                field("Sender Address"; Rec."Sender Address")
                {
                    ApplicationArea = All;
                }
                field(Recipients; Rec.Recipients)
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = All;
                }
                field("Body 2"; Rec."Body 2")
                {
                    ApplicationArea = All;
                }
                field("Body 3"; Rec."Body 3")
                {
                    ApplicationArea = All;
                }
                field(HTMLFormatted; Rec.HTMLFormatted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

