report 70282 "HRM-Internships"
{

    DefaultLayout = RDLC;
    RDLCLayout = './hr/Internship/Reports/SSR/HRMInternships.rdl';

    dataset
    {
        dataitem(HRMIntern; "HRM-Internships&Attachments")
        {
            RequestFilterFields = "Ref No";
            column(Name; HRMIntern.Name)
            {
            }
            column(Campus; HRMIntern.Institution)
            {
            }
            column(Id; HRMIntern."ID No")
            {
            }
            column(Ref; HRMIntern."Ref No")
            {
            }
            column(Yos; HRMIntern."Year Of Study")
            {
            }
            column(DOB; HRMIntern."Date of Birth")
            {
            }
            column(Course; HRMIntern.Course)
            {
            }
            column(Dept; HRMIntern.Department)
            {
            }
            column(Period; HRMIntern.Period)
            {
            }
            column(Sdate; FORMAT(HRMIntern."Start Date"))
            {
            }
            column(Edate; FORMAT(HRMIntern."End Date"))
            {
            }
            column(Speriod; HRMIntern."Period Of Service")
            {
            }
            column(Status; HRMIntern.Active)
            {
            }
            column(Today; FORMAT(TODAY))
            {
            }

            column(logo; info.Picture)
            {

            }
            column(cname; info.Name)
            {

            }
            column(cname2; info."Name 2")
            {

            }
            column(caddress; info.Address)
            {

            }
            column(caddress2; info."Address 2")
            {

            }
            column(mail; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(cphone; info."Phone No.")
            {

            }

            trigger OnPreDataItem()
            begin
                //IF ref.GETFILTER(ref."Ref No")='' THEN ERROR('You must specify the Reference number of the attachee');
                info.get();
                info.CalcFields(Picture);
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

    labels
    {
    }

    var
        ref: Record "HRM-Internships&Attachments";
        info: Record "Company Information";
}