table 50013 hrmTrainingPrograms
{
    Caption = 'hrmTrainingPrograms';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PayrollNo; Code[20])
        {
            Caption = 'PayrollNo';
        }
        field(2; LineNo; Integer)
        {
            Caption = 'LineNo';
            AutoIncrement = true;
        }
        field(3; Priority; Option)
        {
            Caption = 'Priority';
            OptionMembers = "",High,Medium,Low,Other;
        }
        field(4; "Trainning Programme"; Code[20])
        {
            TableRelation = "HRM-Training Courses"."Course Code";
            trigger OnValidate()
            begin
                train.Reset();
                train.SetRange("Course Code", rec."Trainning Programme");
                if train.Find('-') then begin
                    Rec.Description := train."Course Tittle";
                    Rec.Modify();
                end;
            end;

        }
        field(5; "Description"; Code[20])
        {

        }
        field(6; "otherFactors1"; text[100])
        {

        }
        field(7; "otherFactors2"; text[100])
        {

        }
        field(8; "otherFactors3"; text[100])
        {

        }
        
    }
    keys
    {
        key(PK; PayrollNo, LineNo)
        {
            Clustered = true;
        }
    }
    var
        train: Record "HRM-Training Courses";
}
