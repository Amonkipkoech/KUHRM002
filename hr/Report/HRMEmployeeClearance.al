report 50130 "HRMEmployee Clearance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMemployeeClearance.rdl';
    ApplicationArea = Basic, Suite;
    Caption = ' Employeee Clearance';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(clearance; "HRM-Staff Clearance Form")
        {
            column(Clearance_Code; "Clearance Code")
            {

            }
            column(Payroll_Number; "Payroll Number")
            {

            }
            column(Teaching_NonTeaching; "Teaching/NonTeaching")
            {

            }
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(Name; CompanyInformation.Name)
            {

            }
            column(Examinations_submitted; "Examinations submitted")
            {

            }
            column(Supervisions___Assignments; "Supervisions & Assignments")
            {

            }
            column(Equipment_Returned; "Equipment Returned")
            {

            }
            column(Examination_Booklet; "Examination Booklet")
            {

            }
            column(Office_Handed_Over; "Office Handed Over")
            {

            }
            column(Handing_Over_Report_Submitted; "Handing Over Report Submitted")
            {

            }
            column(Staff_ID; "Staff ID")
            {

            }

        }
    }

    requestpage
    {
        layout
        {

        }


        actions
        {

        }
    }
    trigger OnInitReport()
    begin
        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;

    end;

    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
}