page 68078 "GEN-Control-Information"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = Document;
    SourceTable = "HRM-Control-Information";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = all;
                }
                field("Company P.I.N"; Rec."Company P.I.N")
                {
                    ApplicationArea = all;
                }
                field("N.S.S.F No."; Rec."N.S.S.F No.")
                {
                    ApplicationArea = all;
                }
                field("N.H.I.F No"; Rec."N.H.I.F No")
                {
                    ApplicationArea = all;
                }
                field("Company code"; Rec."Company code")
                {
                    ApplicationArea = all;
                }
                field(Mission; Rec.Mission)
                {
                    ApplicationArea = all;
                }
                field(Vision; Rec.Vision)
                {
                    ApplicationArea = all;
                }
                field("Mission/Vision Link"; Rec."Mission/Vision Link")
                {
                    ApplicationArea = all;
                }
                field("Payslip Message"; Rec."Payslip Message")
                {
                    ApplicationArea = all;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = all;
                }
                field("Multiple Payroll"; Rec."Multiple Payroll")
                {
                    ApplicationArea = all;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.1"; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = all;
                }
            }
            group("Physical Address")
            {
                Caption = 'Physical Address';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Caption = 'Name';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    Caption = 'Address';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Caption = 'Address 2';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Post Code/City';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Caption = 'Contact';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Company)
            {
                Caption = 'Company';
                action(Committes)
                {
                    ApplicationArea = all;
                    Caption = 'Committes';
                    RunObject = Page "HRM-Committees (C)";
                }
                action("Board Of Directors")
                {
                    ApplicationArea = all;
                    Caption = 'Board Of Directors';
                    RunObject = Page "HRM-Board of Directors";
                }
                action("Rules & Regulations")
                {
                    ApplicationArea = all;
                    Caption = 'Rules & Regulations';
                    RunObject = Page "HRM-Rules & Regulations";
                }
                action("Company Activities")
                {
                    ApplicationArea = all;
                    Caption = 'Company Activities';
                    RunObject = Page "HRM-Company Activities";
                }
                action("Base Calendar")
                {
                    ApplicationArea = all;
                    Caption = 'Base Calendar';
                    RunObject = Page "Base Calendar Card";
                }
                action("Vendors & Service Providers")
                {
                    ApplicationArea = all;
                    Caption = 'Vendors & Service Providers';
                    RunObject = Page "Vendor Card";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;

    var
        Mail: Codeunit Mail;
        PictureExists: Boolean;
}

