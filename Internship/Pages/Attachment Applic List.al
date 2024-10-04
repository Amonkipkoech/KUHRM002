page 50012 "Attachment Applic List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Internship-Attachment Applic";
    CardPageId = "Attachment Applic";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;

                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;

                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;

                }
                field("ID Card Number"; Rec."ID Card Number")
                {
                    ApplicationArea = All;

                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;

                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;

                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;

                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;

                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    //Editable = false;

                }
                field(Institute; Rec.Institute)
                {
                    ApplicationArea = All;
                    Caption = 'University/Institute Name';

                }
                field("Adm No."; Rec."Adm No.")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;

                }
                field("Disability Status"; Rec."Disability Status")
                {
                    ApplicationArea = All;
                }
                field(PIN; Rec.PIN)
                {
                    ApplicationArea = All;

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