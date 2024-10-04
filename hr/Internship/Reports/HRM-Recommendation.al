report 51726 "HRM-Recommendation"
{

    DefaultLayout = RDLC;
    RDLCLayout = './hr/Internship/Reports/SSR/HRMRecommendation.rdl';

    dataset
    { 
        dataitem(Recomm; "HRM-Internships&Attachments")
        {
            RequestFilterFields = "Ref No";
            column(Name; Recomm.Name)
            {
            }
            column(Campus; Recomm.Institution)
            {
            }
            column(Id; Recomm."ID No")
            {
            }
            column(Ref; Recomm."Ref No")
            {
            }
            column(Yos; Recomm."Year Of Study")
            {
            }
            column(DOB; Recomm."Date of Birth")
            {
            }
            column(Course; Recomm.Course)
            {
            }
            column(Dept; Recomm.Department)
            {
            }
            column(Period; Recomm.Period)
            {
            }
            column(Sdate; FORMAT(Recomm."Start Date"))
            {
            }
            column(Edate; FORMAT(Recomm."End Date"))
            {
            }
            column(Speriod; Recomm."Period Of Service")
            {
            }
            column(Status; Recomm.Active)
            {
            }
            column(Today; FORMAT(TODAY))
            {
            }
            column(Ctype; Recomm."Contract Type")
            {
            }
            column(D1; Recomm."Role 1")
            {
            }
            column(D2; Recomm."Role 2")
            {
            }
            column(D3; Recomm."Role 3")
            {
            }
            column(D4; Recomm."Role 4")
            {
            }
            column(D5; Recomm."Role 5")
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