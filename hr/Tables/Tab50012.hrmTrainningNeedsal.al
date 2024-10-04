table 50012 "hrmTrainningNeeds.al"
{
    Caption = 'hrmTrainningNeeds.al';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; payrollNo; Code[20])
        {

            TableRelation = "HRM-Employee (D)";
            trigger OnValidate()
            begin
                hrEmp.Reset();
                hrEmp.SetRange("No.", Rec.payrollNo);
                if hrEmp.Find('-') then begin
                    rec.employeeName := hrEmp."Full Name";
                    Rec.designation := hrEmp."Job Name";
                    Rec.department := hrEmp."Department Code";
                    Rec.jobGrade := hrEmp."Salary Grade";
                    //Rec.Modify();
                end;


            end;
        }
        field(2; employeeName; Text[200])
        {

        }
        field(3; designation; text[150])
        {

        }
        field(4; department; code[20])
        {

        }
        field(5; jobGrade; code[20])
        {

        }
        field(6; "Training AppNo"; code[20])
        {

        }
    }
    keys
    {
        key(PK; payrollNo)
        {
            Clustered = true;
        }
    }
    var
        hrEmp: Record "HRM-Employee (D)";
        GenLedgerSetup: Record "HRM-Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
