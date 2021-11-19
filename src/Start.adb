pragma SPARK_Mode (On);

with StartLogik;
with StartGrafik;
with StartSound;

procedure Start
is

   task Logik;
   task Grafik;
   task Sound;

   task body Logik
   is begin

      StartLogik.StartLogik;

   end Logik;



   task body Grafik
   is begin

      StartGrafik.StartGrafik;

   end Grafik;



   task body Sound
   is begin

      StartSound.StartSound;

   end Sound;

begin

   null;

end Start;
