page 75030 "HRM-Appraisal Appraisee Target"
{
    PageType = List;
    SourceTable = "HRM-Appraisal Emp. Targets";

    layout
    {
        area(content)
        {
            repeater(rep001)
            {
                field("Appraisal Target Code"; Rec."Appraisal Target Code")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    ApplicationArea = All;
                }
                field("Appraisal year Code"; Rec."Appraisal year Code")
                {
                    ApplicationArea = All;
                }
                field("PF. No."; Rec."PF. No.")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Agreed Performance Targets"; Rec."Agreed Performance Targets")
                {
                    ApplicationArea = All;
                }
                field("Individual Target"; Rec."Individual Target")
                {
                    ApplicationArea = All;
                }
                field("Agreed Score"; Rec."Agreed Score")
                {
                    ApplicationArea = All;
                }
                field("Individual Target Grade"; Rec."Individual Target Grade")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Agreed Score Grade"; Rec."Agreed Score Grade")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Individual Target Comments"; Rec."Individual Target Comments")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Agreed Score Comments"; Rec."Agreed Score Comments")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        UnitStage := '';

        UnitsS.RESET;
        UnitsS.SETRANGE(UnitsS."Appraisal Job Code", Rec."Appraisal Job Code");
        //UnitsS.SETRANGE(UnitsS."Stage Code",Stage);
        UnitsS.SETRANGE(UnitsS.Code, Rec."Appraisal Target Code");
        IF UnitsS.FIND('-') THEN BEGIN
            Desc := UnitsS.Desription;
        END ELSE
            Desc := '';
    end;

    var
        UnitsS: Record "HRM-Appraisal Targets";
        Desc: Text[250];
        UnitStage: Code[20];
        Prog: Record "HRM-Appraisal Jobs";
        ProgDesc: Text[200];
        CReg: Record "HRM-Appraisal Registration";
        StudUnits: Record "HRM-Appraisal Emp. Targets";

    procedure UnitOnActivate()
    begin
        IF Rec."Reg. Transacton ID" = '' THEN BEGIN
            CReg.RESET;
            CReg.SETRANGE(CReg."PF No.", Rec."PF. No.");
            IF CReg.FIND('-') THEN BEGIN
                Rec."Reg. Transacton ID" := CReg."Reg. Transacton ID";
                Rec."Appraisal Job Code" := CReg."Appraisal Job Code";
                Rec."Appraisal Period Code" := CReg."Appraisal Period Code";
            END;
        END;

        UnitsS.RESET;
        UnitsS.SETRANGE(UnitsS.Code, Rec."Appraisal Target Code");
        IF UnitsS.FIND('-') THEN BEGIN
            Desc := UnitsS.Desription;
        END ELSE
            Desc := '';
    end;
}

