/// <summary>
/// Report Training Summary (ID 50103).
/// </summary>
report 50103 "HRMTraining Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMtrainingSummary.rdl';
    Caption = ' Training Summary';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(trainSumm; "HRM-Training Participants")
        {
            column(Training_Code; "Training Code")
            {

            }
            column(Employee_Code; "Employee Code")
            {

            }
            column(Academic_Year;"Academic Year")
            {

            }
            column(Training_Description;"Training Description")
            {
                
            }
            column(Department;Department)
            {

            }
            column(Scholarship_Type;"Scholarship Type")
            {

            }
            column(Scholarship_Period;"Scholarship Period")
            {

            }
            column(Training_Institution;"Training Institution")
            {

            }
            column(Training_Cost;"Training Cost")
            {

            }
            column(Bonding_Required;"Bonding Required")
            {

            }
            column(Bonding_Period;"Bonding Period")
            {

            }
            column(Date_From;"Date From")
            {

            }
            column(Date_To;"Date To")
            {

            }
            column(Completed;Completed)
            {

            }
            column(Certificate_Issued;"Certificate Issued")
            {
                
            }
            column(info;info.Picture)
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
        if info.Get() then begin
            info.CalcFields(info.Picture);
        end;
    end;

    var
        myInt: Integer;
        info: Record "Company Information";
}