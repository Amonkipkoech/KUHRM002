page 68355 "HRM-Company Activities"
{
    PageType = Worksheet;
    SourceTable = "HRM-Company Activities (B)";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Attachement; Rec.Attachement)
                {
                    ApplicationArea = All;
                }
                field(Responsibility; Rec.Responsibility)
                {
                    ApplicationArea = All;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = All;
                }
                field(Control1000000022; Rec.Post)
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Participants)
            {
                Caption = 'Participants';
                action(Employees)
                {
                    Caption = 'Employees';
                    RunObject = Page "HRM-Activity Employess";
                    ApplicationArea = All;
                }
            }
            group("&Attachment")
            {
                Caption = '&Attachment';
                action(Open)
                {
                    Caption = 'Open';
                    ShortCutKey = 'Return';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then
                            InteractTemplLanguage.OpenAttachment;
                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec.Code;
                            InteractTemplLanguage."Language Code" := Rec."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec.Description;
                        end;
                        InteractTemplLanguage.CreateAttachment;
                        CurrPage.Update;
                        Rec.Attachement := Rec.Attachement::Yes;
                        Rec.Modify;
                    end;
                }
                action("Copy &from")
                {
                    Caption = 'Copy &from';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec.Code;
                            InteractTemplLanguage."Language Code" := Rec."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec.Description;
                            InteractTemplLanguage.Insert;
                            Commit;
                        end;
                        InteractTemplLanguage.CopyFromAttachment;
                        CurrPage.Update;
                        Rec.Attachement := Rec.Attachement::Yes;
                        Rec.Modify;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if not InteractTemplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec.Code;
                            InteractTemplLanguage."Language Code" := Rec."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec.Description;
                            InteractTemplLanguage.Insert;
                        end;
                        InteractTemplLanguage.ImportAttachment;
                        CurrPage.Update;
                        Rec.Attachement := Rec.Attachement::Yes;
                        Rec.Modify;
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then
                            InteractTemplLanguage.ExportAttachment;
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if InteractTemplLanguage.Get(Rec.Code, Rec."Language Code (Default)") then begin
                            InteractTemplLanguage.RemoveAttachment(true);
                            Rec.Attachement := Rec.Attachement::No;
                            Rec.Modify;
                        end;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    GenJournal.Reset;
                    GenJournal.SetRange(GenJournal."Journal Template Name", 'GENERAL');
                    GenJournal.SetRange(GenJournal."Journal Batch Name", 'COMP ACT.');
                    GenJournal.DeleteAll;

                    CompanyAct.Reset;
                    CompanyAct.SetRange(CompanyAct.Post, true);
                    CompanyAct.SetRange(CompanyAct.Posted, false);

                    if CompanyAct.Find('-') then begin
                        PostingGroups.Reset;
                        if PostingGroups.Find('-') then begin

                            repeat
                                GenJournal.Init;
                                GenJournal."Journal Template Name" := 'GENERAL';
                                GenJournal."Journal Batch Name" := 'COMP ACT.';
                                GenJournal."Line No." := GenJournal."Line No." + LineNo;
                                GenJournal."Account Type" := GenJournal."Account Type"::"G/L Account";
                                GenJournal."Account No." := PostingGroups."Comp. Act. Debit Account";
                                GenJournal."Posting Date" := WorkDate;
                                GenJournal."Document No." := CompanyAct.Code + '-' + Format(CompanyAct.Day);
                                GenJournal."Bal. Account Type" := GenJournal."Account Type"::"Bank Account";
                                GenJournal."Bal. Account No." := PostingGroups."Comp. Act. Credit Account";
                                GenJournal.Description := CompanyAct.Description + '-' + Format(CompanyAct.Day);
                                GenJournal.Amount := CompanyAct.Costs;
                                GenJournal.Validate(GenJournal.Amount);
                                GenJournal.Insert;

                                CompanyAct.Posted := true;
                                CompanyAct.Modify;
                                LineNo := LineNo + 10000;
                            until CompanyAct.Next = 0;
                        end;
                    end;

                    GenJournal.Reset;
                    GenJournal.SetRange(GenJournal."Journal Template Name", 'GENERAL');
                    GenJournal.SetRange(GenJournal."Journal Batch Name", 'COMP ACT.');
                    if GenJournal.Find('-') then
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJournal);

                    //MESSAGE('%1','Posting Completed Successfully');
                end;
            }
        }
    }

    var
        GenJournal: Record "Gen. Journal Line";
        LineNo: Integer;
        CompanyAct: Record "HRM-Company Activities (B)";
        PostingGroups: Record "HRM-Posting Groups";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
}

