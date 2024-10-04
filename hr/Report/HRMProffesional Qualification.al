/// <summary>
/// Report Proffesional Qualification (ID 50121).
/// </summary>
report 50121 "HRMProffesional Qualification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMproffesionalQualification.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Proffesional Qualification';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(proffesionalQualification; 50006)
        {
            column(Payroll_No_; "Payroll No.")
            {

            }
            column(Qualification_Name; "Qualification Name")
            {

            }
            column(Examination_Body; "Examination Body")
            {

            }
            column(Year_Attained; "Year Attained")
            {

            }
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(Name; CompanyInformation.Name)
            {

            }
            column(Valid_From; "Valid From")
            {

            }
            column(Valid_To; "Valid To")
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