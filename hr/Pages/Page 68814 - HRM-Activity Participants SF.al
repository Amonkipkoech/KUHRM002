page 68814 "HRM-Activity Participants SF"
{
    Caption = 'Activity Participants';
    PageType = Listpart;
    SaveValues = true;
    SourceTable = "HRM-Activity Participants";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(Notified; Rec.Notified)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Participant; Rec.Participant)
                {
                    ApplicationArea = All;
                }
                field("Partipant Name"; Rec."Partipant Name")
                {
                    ApplicationArea = All;
                }
                field(Contribution; Rec.Contribution)
                {
                    ApplicationArea = All;
                }
                field("Email Message"; Rec."Email Message")
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

