/// <summary>
/// Report Disciplinary Cases (ID 50125).
/// </summary>
report 50125 "HRMDisciplinary Cases"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMdisciplinaryCases.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Disciplinary Cases';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(discplinaryCase; 61223)
        {
            column(Accused_Employee; "Accused Employee")
            {

            }
            column(Accused_Employee_Name; "Accused Employee Name")
            {

            }
            column(Campus; Campus)
            {

            }
            column(Case_Category; "Case Category")
            {

            }
            column(Case_Description; "Case Description")
            {

            }
            column(Incident_Date; "Incident Date")
            {

            }
            column(Disc__Committee_Case_Date; "Disc. Committee Case Date")
            {

            }
            column(Disciplinary_Committee_Verdict; "Disciplinary Committee Verdict")
            {

            }
            column(Appeal__Yes_No_; "Appeal (Yes/No)")
            {

            }
            column(Appeal_Date; "Appeal Date")
            {

            }

        
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
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