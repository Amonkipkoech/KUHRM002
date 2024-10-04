/* codeunit 50000 "Process Leave CarryForward"
{

    trigger OnRun()
    begin
    end;

    var
        LeaveRegister: Record "HRM-Salary Increament Register";
        hremployee: Record "HRM-Employee (D)";
        hrLeaveJournal: Record "HRM-Employee Leave Journal";


    procedure postRegister()
    begin
        IF ((DATE2DMY(TODAY, 2) <> 1) AND (DATE2DMY(TODAY, 2) <> 7)) THEN
            ERROR('Salary inrement are only done in January and July');

        IF (DATE2DMY(TODAY, 2) = 1) THEN BEGIN // 1
                                               // Post Inreaments for January
            salaryregister.RESET;
            salaryregister.SETRANGE(salaryregister.Posted, FALSE);
            salaryregister.SETRANGE(salaryregister."Increament Month", 'January');
            salaryregister.SETRANGE(salaryregister."Increament Year", (DATE2DMY(TODAY, 3)));
            IF salaryregister.FIND('-') THEN BEGIN //3
                REPEAT
                BEGIN //4
                    hrSalaryCard.RESET;
                    hrSalaryCard.SETRANGE(hrSalaryCard."Employee Code", salaryregister."Employee No.");
                    IF hrSalaryCard.FIND('-') THEN BEGIN //5
                        hrSalaryCard."Basic Pay" := salaryregister."Current Salary";
                        hrSalaryCard.MODIFY;
                        salaryregister.Posted := TRUE;
                        salaryregister.Reversed := FALSE;
                        salaryregister.MODIFY;
                    END;//5
                END;//4
                UNTIL salaryregister.NEXT = 0;
                MESSAGE('Salary increament for ''JANUARY'' ,''' + FORMAT((DATE2DMY(TODAY, 3))) + ''' Posted Successfully.' +
                '\You can reverse these postings before ''JANUARY'' ends.');
            END //3
            ELSE BEGIN //11
                ERROR('The Register has not been popullated with Increments.');
            END;// 11

        END // 1
        ELSE
            IF (DATE2DMY(TODAY, 2) = 7) THEN BEGIN //2
                                                   // Post Increaments for July

                // Post Inreaments for july
                salaryregister.RESET;
                //salaryregister.SETRANGE(salaryregister.Posted,FALSE);
                salaryregister.SETRANGE(salaryregister."Increament Month", 'July');
                salaryregister.SETRANGE(salaryregister."Increament Year", (DATE2DMY(TODAY, 3)));
                IF salaryregister.FIND('-') THEN BEGIN //7
                    REPEAT
                    BEGIN //9
                        hrSalaryCard.RESET;
                        hrSalaryCard.SETRANGE(hrSalaryCard."Employee Code", salaryregister."Employee No.");
                        hrSalaryCard.SETRANGE("Period Month", 7);
                        hrSalaryCard.SETRANGE(Closed, FALSE);
                        IF hrSalaryCard.FIND('-') THEN BEGIN //8
                            hrSalaryCard."Basic Pay" := salaryregister."Current Salary";
                            hrSalaryCard.MODIFY;
                            salaryregister.Posted := TRUE;
                            salaryregister.Reversed := FALSE;
                            salaryregister.MODIFY;
                        END;//8
                    END;//9
                    UNTIL salaryregister.NEXT = 0;
                    MESSAGE('Salary increament for ''JULY'',' + FORMAT((DATE2DMY(TODAY, 3))) + ''' Posted Successfully.' +
                    '\You can reverse these postings before ''JULY'',' + FORMAT((DATE2DMY(TODAY, 3))) + ''' ends.');
                END //7
                ELSE BEGIN //11
                    ERROR('The Register has not been popullated with Increments.');
                END;// 11

            END;//2

    end;


    procedure ReverseInrementPosting()
    begin
        IF ((DATE2DMY(TODAY, 2) <> 1) AND (DATE2DMY(TODAY, 2) <> 7)) THEN
            ERROR('Salary inrement are only done in January and July');

        IF (DATE2DMY(TODAY, 2) = 1) THEN BEGIN // 1
                                               // Reverse Inrements for January
            salaryregister.RESET;
            salaryregister.SETRANGE(salaryregister.Posted, TRUE);
            salaryregister.SETRANGE(salaryregister."Increament Month", 'JANUARY');
            salaryregister.SETRANGE(salaryregister."Increament Year", (DATE2DMY(TODAY, 3)));
            IF salaryregister.FIND('-') THEN BEGIN //3
                REPEAT
                BEGIN //4
                    hrSalaryCard.RESET;
                    hrSalaryCard.SETRANGE(hrSalaryCard."Employee Code", salaryregister."Employee No.");
                    //hrSalaryCard.SETRANGE("Period Month", 1);

                    IF hrSalaryCard.FIND('-') THEN BEGIN //5
                        hrSalaryCard."Basic Pay" := salaryregister."Prev. Salary";
                        hrSalaryCard.MODIFY;
                        salaryregister.Posted := FALSE;
                        salaryregister.Reversed := TRUE;
                        salaryregister.MODIFY;
                        //Message('Modified Successifully');
                    END;//5
                END;//4
                UNTIL salaryregister.NEXT = 0;
                MESSAGE('Salary increament for ''January'' ,''' + FORMAT((DATE2DMY(TODAY, 3))) + ''' Reversed Successfully.' +
                '\You can Re-Post these postings before ''January'' ends.');
            END //3
            ELSE BEGIN //10
                ERROR('The Register has not been popullated with Increments.');
            END;//10
        END // 1
        ELSE
            IF (DATE2DMY(TODAY, 2) = 7) THEN BEGIN //2
                                                   // Post Increaments for July

                // Reverse Inrements for july
                salaryregister.RESET;
                salaryregister.SETRANGE(salaryregister.Posted, TRUE);
                salaryregister.SETRANGE(salaryregister."Increament Month", 'July');
                salaryregister.SETRANGE(salaryregister."Increament Year", (DATE2DMY(TODAY, 3)));
                IF salaryregister.FIND('-') THEN BEGIN //7
                    REPEAT
                    BEGIN //9
                        hrSalaryCard.RESET;
                        hrSalaryCard.SETRANGE(hrSalaryCard."Employee Code", salaryregister."Employee No.");
                        hrSalaryCard.SETRANGE("Period Month", 7);
                        IF hrSalaryCard.FIND('-') THEN BEGIN //8
                            hrSalaryCard."Basic Pay" := salaryregister."Prev. Salary";
                            hrSalaryCard.MODIFY;
                            salaryregister.Posted := FALSE;
                            salaryregister.Reversed := TRUE;
                            salaryregister.MODIFY;
                        END;//8
                    END;//9
                    UNTIL salaryregister.NEXT = 0;
                    MESSAGE('Salary increament for ''JULY'',' + FORMAT((DATE2DMY(TODAY, 3))) + ''' Reversed Successfully.' +
                    '\You can Re-Post these postings before ''JULY'',' + FORMAT((DATE2DMY(TODAY, 3))) + ''' ends.');
                END //7
                ELSE BEGIN //11
                    ERROR('The Register has not been popullated with Increments.');
                END;// 11

            END;//2
    end;
}

 */