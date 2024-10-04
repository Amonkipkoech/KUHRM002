page 68445 "HRM-Performance Plan"
{
    PageType = ListPart;
    SourceTable = "HRM-Performance Plan";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    ApplicationArea = All;
                }
                field("Agreed Target Date"; Rec."Agreed Target Date")
                {
                    ApplicationArea = All;
                }
                field(Weighting; Rec.Weighting)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF AppraisalTypes.GET(Rec."Appraisal Type") THEN BEGIN
                            IF Rec.Weighting > AppraisalTypes."Max. Weighting" THEN BEGIN
                                MESSAGE('%1', 'Value connot be more than the Max. Weighting');
                                Rec.Weighting := AppraisalTypes."Max. Weighting";
                            END;
                        END;
                    end;
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    ApplicationArea = All;
                }
                field("Score/Points"; Rec."Score/Points")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF AppraisalTypes.GET(Rec."Appraisal Type") THEN BEGIN
                            IF Rec."Score/Points" > AppraisalTypes."Max. Score" THEN BEGIN
                                MESSAGE('%1', 'Value connot be more than the Max. Score');
                                Rec."Score/Points" := AppraisalTypes."Max. Score";
                            END;
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        AppraisalTypes: Record "HRM-Appraisal Types";
}

