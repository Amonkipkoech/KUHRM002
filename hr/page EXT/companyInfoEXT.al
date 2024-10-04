pageextension 60001 "Company Info Ext." extends "Company Information"
{
    layout{
        addafter(Picture){
            
                                              field("Company P.I.N";Rec."Company P.I.N")
                                              {
                                                  ToolTip = 'Specifies CUEA KRA pin';
                                                  ApplicationArea = All;
                                                  Caption= 'CUEA KRA Pin';
                                              }
        }
    }
}