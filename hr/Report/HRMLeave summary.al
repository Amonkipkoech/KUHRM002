/// <summary>
/// Report myreport (ID 50100).
/// </summary>
report 50100 "HRMLeave Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMleavesummary.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Leave Summary';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;



    dataset
    {
        dataitem(leave; "HRM-Leave Requisition")
        {

            column(Employee_No; "Employee No")
            {
            }
            column(Employee_Name; "Employee Name")
            {
            }
            column(Applied_Days; "Applied Days")
            {
            }
            column(Leave_Type; "Leave Type")
            {

            }
            column(Leave_Balance; "Leave Balance")
            {

            }
            column(Process_Leave_Allowance; "Process Leave Allowance")
            {

            }

            column(Pic; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if leaveledger.Get() then begin
                    leaveledger.Get()
                end;
            end;


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
        HrmEmployee: Record "HRM-Employee (D)";
        leaveJournal: Record "HRM-Employee Leave Journal";

        leaveledger: Record "HRM-Leave Ledger";







}