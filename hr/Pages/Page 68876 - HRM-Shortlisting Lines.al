page 68876 "HRM-Shortlisting Lines"
{
    Caption = 'Shorlisted Candidates';
    Editable = false;
    PageType = ListPart;
    SourceTable = "HRM-Shortlisted Applicants";
    SourceTableView = where(Qualified = filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = all;
                    Caption = 'Qualified';

                    trigger OnValidate()
                    begin
                        Rec."Manual Change" := true;
                        Rec.Modify;
                    end;
                }
                field("Job Application No"; Rec."Job Application No")
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
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = all;
                }
                field("Stage Score"; Rec."Stage Score")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Employ; Rec.Employ)
                {
                    ApplicationArea = all;
                    Caption = 'Employed';
                    Visible = false;
                }
                field("Reporting Date"; Rec."Reporting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Manual Change"; Rec."Manual Change")
                {
                    ApplicationArea = all;
                    Caption = 'Manual Change';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        MyCount: Integer;

    procedure GetApplicantNo() AppicantNo: Code[20]
    begin
        //AppicantNo:=Applicant;
    end;
}

