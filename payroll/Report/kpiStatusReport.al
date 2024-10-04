report 84505 "KPI Status Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './payroll/Report/SSR/kpiStatus.rdl';

    dataset
    {
        dataitem(kpiStatus; "HRM-Appraisal Emp. Targets")

        {
            column(PF__No_;"PF. No.")
            {
                
            }
            column(Agreed_Performance_Targets; "Agreed Performance Targets")
            {

            }
            column(Expected_Performance_Indicator; "Expected Performance Indicator")
            {

            }
            column(Mid_Year_Review__Remarks_; "Mid Year Review (Remarks)")
            {

            }
            column(Performance_Percentage; "Performance Percentage")
            {

            }
            column(pic; info.Picture)
            {

            }
            column(compname; info.Name)
            {

            }
            column(compaddress; info.Address)
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

    var
        myInt: Integer;
        info: Record "Company Information";
}