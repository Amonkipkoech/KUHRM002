table 50008 "HRM-Denominations"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "HRM-Denominations";
    LookupPageId = "HRM-Denominations";
    fields
    {
        field(1;Code; Code[10])
        {
            DataClassification = ToBeClassified;
            
        }
         field(2;Name; Text[30])
        {
            DataClassification = ToBeClassified;
            
        }
         field(3;Religion; Code[20])
        {
           
            
        }
    }
    
    keys
    {
        key(Key1; Code)
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