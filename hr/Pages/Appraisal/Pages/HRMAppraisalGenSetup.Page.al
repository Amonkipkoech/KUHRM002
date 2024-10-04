page 75026 "HRM-Appraisal Gen. Setup"
{
    PageType = Card;
    SourceTable = "HRM-Appraisal Gen. Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Appraisal Nos."; Rec."Appraisal Nos.")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Registration Nos."; Rec."Appraisal Registration Nos.")
                {
                    ApplicationArea = All;
                }
                field("Clearance Nos"; Rec."Clearance Nos")
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
        CReg: Record "HRM-Appraisal Registration";
        PDate: Date;
        StudUnit: Record "HRM-Appraisal Emp. Targets";
        Prog: Record "HRM-Appraisal Jobs";
        Units: Record "HRM-Appraisal Targets";
        Cust: Record 18;
        GLEntry: Record 17;
        CustEntry: Record 21;
        CustDet: Record 379;
        //HMSP: Record 61402;
        i: Integer;
        //ExResults: Record 75009;
        BankL: Record 271;
        vendL: Record 25;
        vedDetailed: Record 380;
}

