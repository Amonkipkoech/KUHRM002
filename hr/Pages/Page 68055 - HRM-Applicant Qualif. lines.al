page 68055 "HRM-Applicant Qualif. lines"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "HRM-Applicant Qualif. Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Qualification code"; Rec."Qualification code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if (Rec."To Date" <> 0D) and (Rec."From Date" <> 0D) then
                            Rec."No of Years" := Rec."To Date" - Rec."From Date";
                    end;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                }
                field("No of Years"; Rec."No of Years")
                {
                    Caption = 'No of days';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Score"; Rec."Actual Score")
                {
                    ApplicationArea = All;
                }
                field("Desired Score"; Rec."Desired Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Year: Integer;
}

