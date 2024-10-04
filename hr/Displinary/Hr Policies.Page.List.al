page 75060 "HR Policies List"
{
    SourceTable = "HR Policies";

    layout
    {
        area(Content)
        {
            field(Chapter; Rec.Chapter)
            {
                ApplicationArea = All;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
            field(AdoptionPeriod; Rec."Period Effected")
            {
                ApplicationArea = aLL;
            }
            field(Active; Rec.Active)
            {
                ApplicationArea = All;

            }
        }
    }
}