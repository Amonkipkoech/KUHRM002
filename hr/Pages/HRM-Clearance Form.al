page 70047 "HRM-Clearance Form"
{
    Caption = 'Clearance Form';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HRM-Staff Clearance Form";

    layout
    {
        area(Content)
        {
            group("Staff Information")
            {
                field("Clearance Code"; Rec."Clearance Code")
                {
                    ToolTip = 'Specifies the value of the Clearance Code field.';
                    ApplicationArea = All;
                }

                field("Payroll Number"; Rec."Payroll Number")
                {

                    ToolTip = 'Specifies the value of the Payroll Number field.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin

                        HRMEmployee.Reset();
                        HRMEmployee.SetRange("No.", Rec."Payroll Number");
                        if HRMEmployee.Find('-') then begin
                            HRMEmployee."clearance initiated" := true;
                            HRMEmployee.Modify();
                            Rec."Staff Name" := HRMEmployee."Full Name";
                            Rec.Modify();
                        end;


                    end;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Teaching/NonTeaching"; Rec."Teaching/NonTeaching")
                {
                    ToolTip = 'Specifies the value of the Teaching/NonTeaching field.';
                    ApplicationArea = All;
                }
            }
            group("Head of Department ")
            {

                field("Examination Booklet"; Rec."Examination Booklet")
                {
                    ToolTip = 'Specifies the value of the Examinations Booklet & Mark Sheets submitted field.';
                    ApplicationArea = All;
                }
                field("Examinations submitted"; Rec."Examinations submitted")
                {
                    ToolTip = 'Specifies the value of the Examinations submitted field.';
                    ApplicationArea = All;
                }
                field("Teaching Material submitted"; Rec."Teaching Material submitted")
                {
                    ToolTip = 'Specifies the value of the Teaching Material submitted field.';
                    ApplicationArea = All;
                }
                field("Supervisions & Assignments"; Rec."Supervisions & Assignments")
                {
                    ToolTip = 'Specifies the value of the Supervisions & Any Assignments Handed Over field.';
                    ApplicationArea = All;
                }
                field("Equipment Returned"; Rec."Equipment Returned")
                {
                    ToolTip = 'Specifies the value of the Equipment Returned field.';
                    ApplicationArea = All;
                }

                field("Handing Over Report Submitted"; Rec."Handing Over Report Submitted")
                {
                    ToolTip = 'Specifies the value of the Handing Over Report Submitted field.';
                    ApplicationArea = All;
                }
                field("Office Handed Over"; Rec."Office Handed Over")
                {
                    ToolTip = 'Specifies the value of the Office Handed Over field.';
                    ApplicationArea = All;
                }
                field("Staff ID"; Rec."Staff ID")
                {
                    ToolTip = 'Specifies the value of the Handing Over Report Submitted field.';
                    ApplicationArea = All;
                }
                field("Date of Clearance by HoD"; Rec."Date of Clearance by HoD")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by HoD field.';
                    ApplicationArea = All;
                }

            }
            group("Store Clearance")
            {

                field("Store Equipment returned"; Rec."Store Equipment returned")
                {
                    ToolTip = 'Specifies the value of the Handing Over Report Submitted field.';
                    ApplicationArea = All;
                }
                field("Date of Clearance Stores"; Rec."Date of Clearance Stores")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by Stores Officer field.';
                    ApplicationArea = All;
                }
                field("Store Officer Staff ID"; Rec."Store Officer Staff ID")
                {
                    ToolTip = 'Specifies the value of the Clearing Stores Officer Staff ID field.';
                    ApplicationArea = All;
                }
            }

            group("Maintenance Clearance")
            {
                field("Equip issued returned"; Rec."Equip issued returned")
                {
                    ToolTip = 'Specifies the value of the Equip issued returned field.';
                    ApplicationArea = All;
                }

                field("Date Cleared By Maintenance"; Rec."Date Cleared By Maintenance")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by Maintenance Officer field.';
                    ApplicationArea = All;
                }
                field("Items Issued Code"; Rec."Items Issued Code")
                {
                    ToolTip = 'Specifies the value of the Items Issued Code field.';
                    ApplicationArea = All;
                }
                field("Maintenance Officer ID"; Rec."Maintenance Officer ID")
                {
                    ToolTip = 'Specifies the value of the Clearing Maintenance officer Staff ID field.';
                    ApplicationArea = All;
                }
            }

            group("Library Clearance")
            {
                field("Books Borrowed"; Rec."Books Borrowed")
                {
                    ToolTip = 'Specifies the value of the Borrowed Books field.';
                    ApplicationArea = All;
                }
                field("OverDue Charges"; Rec."OverDue Charges")
                {
                    ToolTip = 'Specifies the value of the OverDue Charges field.';
                    ApplicationArea = All;
                }

                field("Librarian Staff ID"; Rec."Librarian Staff ID")
                {
                    ToolTip = 'Specifies the value of the Clearing University Librarian Staff ID field.';
                    ApplicationArea = All;
                }
                field("Date of Clearance Librarian"; Rec."Date of Clearance Librarian")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by University Librarian field.';
                    ApplicationArea = All;
                }
            }
            group("Finance Clearance")
            {

                field("Petty Cash Surrender"; Rec."Petty Cash Surrender")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Surrender field.';
                    ApplicationArea = All;
                }
                field("Credit Control"; Rec."Credit Control")
                {
                    ToolTip = 'Specifies the value of the Credit Control field.';
                    ApplicationArea = All;
                }
                field("Clearing CFO ID"; Rec."Clearing CFO ID")
                {
                    ToolTip = 'Specifies the value of the Clearing CFO Staff ID field.';
                    ApplicationArea = All;
                }
                field("Date Cleared By CFO"; Rec."Date Cleared By CFO")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by the CFO field.';
                    ApplicationArea = All;
                }
            }
            group("Payroll Clearance")
            {
                field("Outstanding CUEA Loans"; Rec."Outstanding CUEA Loans")
                {
                    ToolTip = 'Specifies the value of the Outstanding CUEA Loans field.';
                    ApplicationArea = All;
                }
                field("Outstanding Arrears"; Rec."Outstanding Arrears")
                {
                    ToolTip = 'Specifies the value of the Outstanding Arrears field.';
                    ApplicationArea = All;
                }
                field("Outstanding salary Advances"; Rec."Outstanding salary Advances")
                {
                    ToolTip = 'Specifies the value of the Outstanding salary Advances field.';
                    ApplicationArea = All;
                }

                field("Payroll Officer Staff ID"; Rec."Payroll Officer Staff ID")
                {
                    ToolTip = 'Specifies the value of the Clearing Payroll Officer Staff ID field.';
                    ApplicationArea = All;
                }
                field("Date  Cleared by Payroll"; Rec."Date  Cleared by Payroll")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by Payroll Officer field.';
                    ApplicationArea = All;
                }
            }
            group("ICT Clearance")
            {
                field("Rights to systems disabled"; Rec."Rights to systems disabled")
                {
                    ToolTip = 'Specifies the value of the Rights to systems and staff e-mail disabled field.';
                    ApplicationArea = All;
                }

                field("Clearing ICT officer Staff ID"; Rec."Clearing ICT officer Staff ID")
                {
                    ToolTip = 'Specifies the value of the Clearing ICT officer Staff ID field.';
                    ApplicationArea = All;
                }
                field("Date of Clearance by ICT"; Rec."Date of Clearance by ICT")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by ICT Officer field.';
                    ApplicationArea = All;
                }
            }
            group("Medical Clearance")
            {

                field("Medical cards/Staff ID Retrned"; Rec."Medical cards/Staff ID Retrned")
                {
                    ToolTip = 'Specifies the value of the All Medical cards and Staff ID Returned field.';
                    ApplicationArea = All;
                }
                field("Clearing Medical Officer"; Rec."Clearing Medical Officer")
                {
                    ToolTip = 'Specifies the value of the Clearing ICT officer Staff ID field.';
                    ApplicationArea = All;
                }
                field("Date  Cleared by Med.Office"; Rec."Date  Cleared by Med.Office")
                {
                    ToolTip = 'Specifies the value of the Date of Clearance by Medical Office field.';
                    ApplicationArea = All;
                }
            }
            group("HRM Clearance")
            {

                field("Clearance by the HR Manager"; Rec."Clearance by the HR Manager")
                {
                    ToolTip = 'Specifies the value of the Clearance by the HR Manager field.';
                    ApplicationArea = All;
                }
                field("HRM Staff ID"; Rec."HRM Staff ID")
                {
                    ToolTip = 'Specifies the value of the HRM Staff ID field.';
                    ApplicationArea = All;
                }
                field("HRM Clearance Date"; Rec."HRM Clearance Date")
                {
                    ToolTip = 'Specifies the value of the HRM Clearance Date field.';
                    ApplicationArea = All;
                }

            }
            group("Clearence Status")
            {
                field("Status Of Clearence"; Rec."Status Of Clearence")
                {
                    ApplicationArea = all;
                }
                field("Clearence Comment"; Rec."Clearence Comment")
                {
                    MultiLine = true;
                    ApplicationArea = all;
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
                Caption = 'Initiate Clearance';

                trigger OnAction()
                begin

                    Rec."Clearance Status" := Rec."Clearance Status"::Academic;

                end;
            }
        }
    }

    var
        myInt: Integer;
        HRMEmployee: Record "HRM-Employee (D)";
        empName: Text[100];
}