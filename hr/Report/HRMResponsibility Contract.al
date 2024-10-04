/// <summary>
/// Report Responsibility Contract (ID 50124).
/// </summary>
report 50124 "HRMResponsibility Contract"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/HRMresponsibilityContract.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Responsibility Contract';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(responsibilityContract; "HRM Responsiblities Contract")
        {
            RequestFilterFields = "Campus Code", "Department Code", Faculty;
            column(Payroll_No_; "Payroll No.")
            {

            }
            column(Responsibility_Description; "Responsibility Description")
            {

            }
            column(Department_Code; "Department Code")
            {

            }
            column(Expiry_Notificaion_date; Format("Expiry Notificaion date"))
            {

            }
            column(Department; Department)
            {

            }
            column(Faculty; Faculty)
            {

            }
            column(From_Date; "From Date")
            {

            }
            column(To_Date; "To Date")
            {

            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(Name; CompanyInformation.Name)
            {

            }
            column(empNames; empNames)
            {

            }
            column(departName; departName)
            {

            }
            column(depart; depart)
            {

            }
            trigger OnAfterGetRecord()
            begin
                hrEmp.Reset();
                hrEmp.SetRange("No.", responsibilityContract."Payroll No.");
                IF hrEmp.Find('-') then begin
                    empNames := hrEmp."First Name" + ' ' + hrEmp."Middle Name" + ' ' + hrEmp."Last Name";
                    depart := hrEmp."Department Code";
                    dimVal.Reset();
                    dimVal.SetRange(Code, depart);
                    if dimVal.Find('-') then begin
                        departName := dimVal.Name;
                    end;
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
        hrEmp: Record "HRM-Employee (D)";
        dimVal: Record "Dimension Value";
        empNames, depart, departName : Text;

}