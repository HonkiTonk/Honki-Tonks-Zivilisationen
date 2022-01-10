pragma SPARK_Mode (On);

with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with StartLogik;
with StartGrafik;
with StartSound;

-- with FOSDEM;

procedure Start
is

   -- RecordStartAttempt : constant Positive := 2;
   -- RecordTasksAttempt : constant Positive := 4;

   type Tasks_Enum is (Task_Logik, Task_Grafik, Task_Sound);

   type TasksLaufenArray is array (Tasks_Enum'Range) of Boolean;
   TasksLaufen : TasksLaufenArray;

   type TaskIDArray is array (Tasks_Enum'Range) of Task_Id;
   TaskID : TaskIDArray;

   task Logik;
   task Grafik;
   task Sound;

   task body Logik
   is begin

      TaskID (Task_Logik) := Current_Task;

      TasksLaufen (Task_Logik) := True;
      StartLogik.StartLogik;
      TasksLaufen (Task_Logik) := False;

   end Logik;



   task body Grafik
   is begin

      TaskID (Task_Grafik) := Current_Task;

      TasksLaufen (Task_Grafik) := True;
      StartGrafik.StartGrafik;
      TasksLaufen (Task_Grafik) := False;

   end Grafik;



   task body Sound
   is begin

      TaskID (Task_Sound) := Current_Task;

      TasksLaufen (Task_Sound) := True;
      StartSound.StartSound;
      TasksLaufen (Task_Sound) := False;

   end Sound;

begin

   TaskIDsBelegenLassenSchleife:
   loop

      if
        TasksLaufen (Task_Logik) = True
        and
          TasksLaufen (Task_Grafik) = True
        and
          TasksLaufen (Task_Sound) = True
      then
         exit TaskIDsBelegenLassenSchleife;

      else
         delay 0.02;
      end if;

   end loop TaskIDsBelegenLassenSchleife;



   SpielLäuftSchleife:
   loop

      if
        TasksLaufen (Task_Logik) = False
        and
          TasksLaufen (Task_Grafik) = False
        and
          TasksLaufen (Task_Sound) = False
      then
         exit SpielLäuftSchleife;

      elsif
        Is_Terminated (T => TaskID (Task_Logik)) = True
        and
          TasksLaufen (Task_Logik) = True
      then
         Abort_Task (T => TaskID (Task_Grafik));
         Abort_Task (T => TaskID (Task_Sound));
         Put_Line (Item => "Logiktask wurde abgebrochen.");
         exit SpielLäuftSchleife;

      elsif
        Is_Terminated (T => TaskID (Task_Grafik)) = True
        and
          TasksLaufen (Task_Grafik) = True
      then
         Abort_Task (T => TaskID (Task_Logik));
         Abort_Task (T => TaskID (Task_Sound));
         Put_Line (Item => "Grafiktask wurde abgebrochen.");
         exit SpielLäuftSchleife;

      elsif
        Is_Terminated (T => TaskID (Task_Sound)) = True
        and
          TasksLaufen (Task_Sound) = True
      then
         Abort_Task (T => TaskID (Task_Logik));
         Abort_Task (T => TaskID (Task_Grafik));
         Put_Line (Item => "Soundtask wurde abgebrochen.");
         exit SpielLäuftSchleife;

      else
         delay 0.20;
      end if;

   end loop SpielLäuftSchleife;

   -- Put_Line (FOSDEM.RecordStringsAttempt'Wide_Wide_Image);
   -- Put_Line (RecordStartAttempt'Wide_Wide_Image);
   -- Put_Line (RecordTasksAttempt'Wide_Wide_Image);

end Start;
