table 85537 "HRM-Minimun Job Requirements"
{
    DataClassification = ToBeClassified;
    
    fields
    {
       field(1; "Job ID"; Code[50])
        {
            Caption = 'Primary Job Title';
            TableRelation = "HRM-Jobs";
        }
        field(2; "Minimum Requirements"; text[300])
        {

        }
        field(3; Entry; code[10])
        {

        }
    }
    
    keys
    {
        key(Key1; "Job ID", "Minimum Requirements",Entry)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}