page 85508 "App Prof Qualifications"
{
    Caption = 'Applicant Professional Qualification';
    PageType = List;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HRM-Prof Qualification";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
               field("Proffesional Qualification";Rec."Proffesional Qualification")
               {
ApplicationArea = All;
               }
               field("Awarding Body";Rec."Awarding Body")
               {
ApplicationArea = All;
               }
               field("Year Awarded";Rec."Year Awarded")
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

