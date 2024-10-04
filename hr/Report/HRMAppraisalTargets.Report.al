report 51201 "HRM Appraisal Targets"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/AppraisalTargets.rdl';

    dataset
    {
        dataitem(AppTarget; "HRM-Appraisal Emp. Targets")
        {
            column(PF__No_; "PF. No.")
            {

            }
            column(Appraisal_year_Code; "Appraisal year Code")
            {

            }
            column(Appraisal_Target_Code; "Appraisal Target Code")
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
            column(Individual_Target; "Individual Target")
            {

            }
            column(Agreed_Score; "Agreed Score")
            {

            }
            column(Performance_Percentage; "Performance Percentage")
            {

            }
            column(name; info.Name)
            {

            }
            column(name2; info."Name 2")
            {

            }
            column(logo; info.Picture)
            {

            }
            column(mail; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(phone; info."Phone No.")
            {

            }
            column(address; info.Address)
            {

            }
            column(address2; info."Address 2")
            {

            }
            trigger OnPreDataItem()
            begin
                info.Get();
                info.CalcFields(Picture);
            end;
        }
    }
    var
        info: Record "Company Information";
}