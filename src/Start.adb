pragma SPARK_Mode (On);

with Ada.Task_Identification; use Ada.Task_Identification;

with StartLogik;
with StartGrafik;
with StartSound;

with SFMLDarstellungEinstellungen;

procedure Start
is

   type TasksLaufenArray is array (1 .. 3) of Boolean;
   TasksLaufen : TasksLaufenArray := (others => True);

   task Logik;
   task Grafik;
   task Sound;

   task body Logik
   is begin

      StartLogik.StartLogik;
      TasksLaufen (1) := False;

   end Logik;



   task body Grafik
   is begin

      StartGrafik.StartGrafik;
      TasksLaufen (2) := False;

   end Grafik;



   task body Sound
   is begin

      StartSound.StartSound;
      TasksLaufen (3) := False;

   end Sound;

begin

   SpielLäuftSchleife:
   loop

      if
        TasksLaufen = (False, False, False)
      then
         exit SpielLäuftSchleife;

      elsif
        SFMLDarstellungEinstellungen.KritischesProblem
      then
         Abort_Task (T => Current_Task);

      else
         delay 0.20;
      end if;

   end loop SpielLäuftSchleife;

end Start;
