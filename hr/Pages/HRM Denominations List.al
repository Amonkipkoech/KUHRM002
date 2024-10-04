page 50018 "HRM-Denominations"
{
    Caption = 'Denomination';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HRM-Denominations";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
}