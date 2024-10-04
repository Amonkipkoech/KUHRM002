page 68928 "HRM-Email Parameters List"
{
    CardPageID = "HRM- EMail Parameters";
    PageType = List;
    SourceTable = "HRM-EMail Parameters";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Associate With"; Rec."Associate With")
                {
                    ApplicationArea = all;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = all;
                }
                field("Sender Address"; Rec."Sender Address")
                {
                    ApplicationArea = all;
                }
                field(Recipients; Rec.Recipients)
                {
                    ApplicationArea = all;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = all;
                }
                field(Body; Rec.Body)
                {
                    ApplicationArea = all;
                }
                field("Body 2"; Rec."Body 2")
                {
                    ApplicationArea = all;
                }
                field(HTMLFormatted; Rec.HTMLFormatted)
                {
                    ApplicationArea = all;
                }
                field("Body 3"; Rec."Body 3")
                {
                    ApplicationArea = all;
                }
                field("Body 4"; Rec."Body 4")
                {
                    ApplicationArea = all;
                }
                field("Body 5"; Rec."Body 5")
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

