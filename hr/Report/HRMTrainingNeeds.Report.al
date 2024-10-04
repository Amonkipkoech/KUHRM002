report 51721 "HRM-Training Needs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Report/SSR/TrainingNeeds.rdl';

    dataset
    {
        dataitem(TrainNeed; "HRM-Appraisal Training Needs")
        {
            column(PF__No_; "PF. No.")
            {

            }
            column(Appraisal_year_Code; "Appraisal year Code")
            {

            }
            column(Appraisal_Period_Code; "Appraisal Period Code")
            {

            }
            column(Training_Need_Code; "Training Need Code")
            {

            }
            column(Duration_of_Tranning;"Duration of Tranning")
            {

            }
            column(Training_offered; "Training offered")
            {

            }
            column(Comments_Of_staff_Trainning;"Comments Of staff Trainning")
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