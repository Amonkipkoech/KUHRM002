page 68442 "HRM-Job Applications Factbox"
{
    PageType = ListPart;
    SourceTable = "HRM-Job Applications (B)";

    layout
    {
        area(content)
        {
            field(GeneralInfo; GeneralInfo)
            {
                ApplicationArea = all;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Application No"; Rec."Application No")
            {
                ApplicationArea = all;
            }
            field("Date Applied"; Rec."Date Applied")
            {
                ApplicationArea = all;
            }
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = all;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = all;
            }
            field("Last Name"; Rec."Last Name")
            {
                ApplicationArea = all;
            }
            field(Qualified; Rec.Qualified)
            {
                ApplicationArea = all;
            }
            field("Interview Invitation Sent"; Rec."Interview Invitation Sent")
            {
                ApplicationArea = all;
            }
            field("ID Number"; Rec."ID Number")
            {
                ApplicationArea = all;
            }
            field(PersonalInfo; PersonalInfo)
            {
                ApplicationArea = all;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = all;
            }
            field(Age; Rec.Age)
            {
                ApplicationArea = all;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = all;
            }
            field(CommunicationInfo; CommunicationInfo)
            {
                ApplicationArea = all;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            field("Cell Phone Number"; Rec."Cell Phone Number")
            {
                ApplicationArea = all;
                ExtendedDatatype = PhoneNo;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
                ExtendedDatatype = EMail;
            }
            field("Work Phone Number"; Rec."Work Phone Number")
            {
                ApplicationArea = all;
                ExtendedDatatype = PhoneNo;
            }
        }
    }

    actions
    {
    }

    var
        GeneralInfo: Label 'General Applicant Information';
        PersonalInfo: Label 'Personal Infomation';
        CommunicationInfo: Label 'Communication Information';
}

