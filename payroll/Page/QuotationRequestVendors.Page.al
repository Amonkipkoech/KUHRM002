/* page 62251 "Quotation Request Vendors"
{
    PageType = Card;
    SourceTable = 61051;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; "Vendor No.")
                {
                }
                field("Vendor Name"; "Vendor Name")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(printrfq)
            {
                Caption = 'Print RFQ';
                Image = PrintForm;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PROCQuotationRequestVendors.RESET;
                    PROCQuotationRequestVendors.SETRANGE("Document Type", PROCQuotationRequestVendors."Document Type"::"Quotation Request");
                    PROCQuotationRequestVendors.SETRANGE("Document No.", Rec."Document No.");
                    PROCQuotationRequestVendors.SETRANGE("Vendor No.", Rec."Vendor No.");
                    IF PROCQuotationRequestVendors.FIND('-') THEN
                        REPORT.RUN(51074, TRUE, FALSE, PROCQuotationRequestVendors);
                end;
            }
        }
    }

    var
        PROCQuotationRequestVendors: Record "61051";
}

 */