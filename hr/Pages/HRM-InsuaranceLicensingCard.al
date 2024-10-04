page 50024 "License/Statutory"
{
    PageType = Card;
    SourceTable = 50011;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Issuing Body"; Rec."Issuing Body")
                {
                    ApplicationArea = all;
                }

                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = all;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = all;
                }

                field("Notify Before"; Rec."Notify Before")
                {
                    ApplicationArea = all;
                }
                field("Notification Sent"; Rec."Notification Sent")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Send Mail';
                Visible = false;


                trigger OnAction();
                var
                    EmailSubject: Text[50];
                    EmailBody: Text[250];
                    EmailRecipient: List of [Text];
                begin
                    Clear(EmailBody);
                    Clear(EmailSubject);
                    Clear(EmailRecipient);

                    UserSetup.Reset();
                    UserSetup.SetRange("User ID", UserId);
                    if UserSetup.FindFirst() then begin

                        //vlidate emaill account
                        UserSetup.TestField("E-Mail");

                        if not smtpSetup.CheckValidEmailAddress(UserSetup."E-Mail") then
                            Message('Invalid email address : %1', UserSetup."E-Mail");


                        // get recipent and send mail
                        //  EmailAccount.Reset();
                        // if not EmailAccount.FindFirst() then Error('SetUp Email Account');

                        EmailSubject := 'License Notification';
                        EmailBody := rec.Code + ' / ' + Rec.Name + ' / ' + Rec."Issuing Body";
                        EmailRecipient.Add(UserSetup."E-Mail");

                        // if smtpSetup.CheckValidEmailAddress(EmailAccount."Email Address") then begin
                        //     SendMail.GetBody();
                        //     SendMail.Create(UserSetup."E-Mail", EmailSubject, EmailBody);
                        //     if SendMail.Run() then
                        //         Message('Mail Sent Succeffully') else
                        //         Message('Error Sending Mail');
                        // end;


                        // using smtp mail
                        
                        // smtpMail.CreateMessage('HRM CUEA','johnzilla820@gmail.com',EmailRecipient,EmailSubject,EmailBody);
                        // if not smtpMail.Send() then smtpMail.SendShowError();


                    end;


                end;
            }
        }
    }
    var
        smtpSetup: Codeunit "Mail Management";
        UserSetup: Record "User Setup";
        // EmailAccount: Record "SMTP Mail Setup";
        // SendMail: Codeunit "Email Message";
        // smtpMail: Codeunit "SMTP Mail";

}