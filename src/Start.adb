pragma SPARK_Mode (On);

with Ada.Task_Identification; use Ada.Task_Identification;

with StartLogik;
with StartGrafik;
with StartSound;

with Fehler;

procedure Start
is

   LogikID : Task_Id;
   GrafikID : Task_Id;
   SoundID : Task_Id;

   type Tasks_Enum is (Task_Logik, Task_Grafik, Task_Sound);

   type TasksLaufenArray is array (Tasks_Enum'Range) of Boolean;
   TasksLaufen : TasksLaufenArray;

   task Logik;
   task Grafik;
   task Sound;

   task body Logik
   is begin

      LogikID := Current_Task;

      TasksLaufen (Task_Logik) := True;
      StartLogik.StartLogik;
      TasksLaufen (Task_Logik) := False;

   end Logik;



   task body Grafik
   is begin

      GrafikID := Current_Task;

      TasksLaufen (Task_Grafik) := True;
      StartGrafik.StartGrafik;
      TasksLaufen (Task_Grafik) := False;

   end Grafik;



   task body Sound
   is begin

      SoundID := Current_Task;

      TasksLaufen (Task_Sound) := True;
      StartSound.StartSound;
      TasksLaufen (Task_Sound) := False;

   end Sound;

begin

   TaskIDsBelegenLassenSchleife:
   loop

      if
        TasksLaufen = (True, True, True)
      then
         exit TaskIDsBelegenLassenSchleife;

      else
         delay 0.02;
      end if;

   end loop TaskIDsBelegenLassenSchleife;



   SpielLäuftSchleife:
   loop

      if
        TasksLaufen = (False, False, False)
      then
         exit SpielLäuftSchleife;

      elsif
        (Is_Terminated (T => LogikID) = True
         and
           TasksLaufen (Task_Logik) = True)
        or
          Fehler.KritischesProblemLogik
      then
         Abort_Task (T => GrafikID);
         Abort_Task (T => SoundID);
         exit SpielLäuftSchleife;

      elsif
        (Is_Terminated (T => GrafikID) = True
         and
           TasksLaufen (Task_Grafik) = True)
        or
          Fehler.KritischesProblemGrafik
      then
         Abort_Task (T => LogikID);
         Abort_Task (T => GrafikID);
         exit SpielLäuftSchleife;

      elsif
        (Is_Terminated (T => SoundID) = True
         and
           TasksLaufen (Task_Sound) = True)
        or
          Fehler.KritischesProblemSound
      then
         Abort_Task (T => LogikID);
         Abort_Task (T => GrafikID);
         exit SpielLäuftSchleife;

      else
         delay 0.20;
      end if;

   end loop SpielLäuftSchleife;

end Start;
