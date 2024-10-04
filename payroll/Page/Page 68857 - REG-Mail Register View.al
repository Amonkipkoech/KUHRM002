page 68857 "REG-Mail Register View"
{
    Editable = false;
    PageType = List;
    SourceTable = "REG-Mail Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Subject of Doc."; Rec."Subject of Doc.")
                {
                    ApplicationArea = All;
                }
                field("Mail Date"; Rec."Mail Date")
                {
                    ApplicationArea = All;
                }
                field(Addressee; Rec.Addressee)
                {
                    ApplicationArea = All;
                }
                field("mail Time"; Rec."mail Time")
                {
                    ApplicationArea = All;
                }
                field(Receiver; Rec.Receiver)
                {
                    ApplicationArea = All;
                }
                field("Addresee Type"; Rec."Addresee Type")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field("Doc type"; Rec."Doc type")
                {
                    ApplicationArea = All;
                }
                field("Cheque Amount"; Rec."Cheque Amount")
                {
                    ApplicationArea = All;
                }
                field("Direction Type"; Rec."Direction Type")
                {
                    ApplicationArea = All;
                }
                field("Folio Number"; Rec."Folio Number")
                {
                    ApplicationArea = All;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = All;
                }
                field(Dispatched; Rec.Dispatched)
                {
                    ApplicationArea = All;
                }
                field("Dispatched by"; Rec."Dispatched by")
                {
                    ApplicationArea = All;
                }
                field("stamp cost"; Rec."stamp cost")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Doc Ref No."; Rec."Doc Ref No.")
                {
                    ApplicationArea = All;
                }
                field("File Tab"; Rec."File Tab")
                {
                    ApplicationArea = All;
                }
                field("Folio No"; Rec."Folio No")
                {
                    ApplicationArea = All;
                }
                field("Person Recording"; Rec."Person Recording")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Mail)"; Rec."Delivered By (Mail)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Phone)"; Rec."Delivered By (Phone)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Name)"; Rec."Delivered By (Name)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (ID)"; Rec."Delivered By (ID)")
                {
                    ApplicationArea = All;
                }
                field("Delivered By (Town)"; Rec."Delivered By (Town)")
                {
                    ApplicationArea = All;
                }
                field("Mail Status"; Rec."Mail Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Disp)
            {
                Caption = 'Dispatch';
                Image = ReleaseShipment;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TestField("Subject of Doc.");
                    Rec.TestField("Mail Date");
                    Rec.TestField(Addressee);
                    Rec.TestField("mail Time");
                    Rec.TestField(Receiver);
                    Rec.TestField(Comments);
                    Rec.TestField("Delivered By (Mail)");
                    Rec.TestField("Delivered By (Phone)");
                    Rec.TestField("Delivered By (Name)");
                    Rec.TestField("Delivered By (ID)");
                    Rec.TestField("Delivered By (Town)");

                    if (Confirm('Send mail to dispatch?', true) = true) then begin
                        Rec."Mail Status" := Rec."Mail Status"::Dispatch;
                        Rec.Modify;
                    end;
                    Message('Successfully send to dispatch.');
                end;
            }
        }
    }
}

