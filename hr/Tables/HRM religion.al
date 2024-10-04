Page 50013 "Religion List"
{
    Caption = 'Religion';
    SourceTable = "ACA-Religions";
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                

                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the value of the Religion field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Description';
                    ApplicationArea = All;
                }
            }
        }


    }


}