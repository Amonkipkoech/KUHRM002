xmlport 50023 "Transaction Code"
{
    Caption = 'Import Transaction Codes';

    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF16;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(employee; "PRL-Transaction Codes")
            {




                fieldelement(TransactionCode; employee."Transaction Code")
                {
                }
                fieldelement(TransactionName; employee."Transaction Name")
                {
                }
                fieldelement(TransactionType; employee."Transaction Type")
                {
                }
            }
        }
    }
    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        I := 0;
    end;

    var
        I: Integer;
}

