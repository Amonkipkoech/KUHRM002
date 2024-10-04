table 50942 "update"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; payrollNo; code[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(2; name; text[200])
        {

        }
        
    }
    
    keys
    {
        key(Key1; payrollNo)
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