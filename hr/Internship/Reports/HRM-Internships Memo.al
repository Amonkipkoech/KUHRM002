report 51724 "HRM-Internships Memo"
{

    DefaultLayout = RDLC;
    RDLCLayout = './hr/Internship/Reports/SSR/HRMInternshipsMemo.rdl';

    dataset
    {
        dataitem(memo1; "HRM-Internships&Attachments")
        {
            RequestFilterFields = "Ref No";
            column(Name; memo1.Name)
            {
            }
            column(Campus; memo1.Institution)
            {
            }
            column(Id; memo1."ID No")
            {
            }
            column(Ref; memo1."Ref No")
            {
            }
            column(Yos; memo1."Year Of Study")
            {
            }
            column(DOB; memo1."Date of Birth")
            {
            }
            column(Course; memo1.Course)
            {
            }
            column(Dept; memo1.Department)
            {
            }
            column(Period; memo1.Period)
            {
            }
            column(Sdate; FORMAT(memo1."Start Date"))
            {
            }
            column(Edate; FORMAT(memo1."End Date"))
            {
            }
            column(Speriod; memo1."Period Of Service")
            {
            }
            column(Status; memo1.Active)
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