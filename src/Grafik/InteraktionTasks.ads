pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionTasks is

   -- Logiktask
   FensterErzeugt : Boolean := False;
   
   -- Minimal möglicher Wert: 0.000000002 
   WartezeitLogik : constant Duration := 0.20;
   -- Logiktask
   
   
   
   -- Grafiktask
   ErzeugeFenster : Boolean := False;
   Eingabe : Boolean := False;
   FensterVerändert : Boolean := False;
   
   AktuelleDarstellung : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.SFML_Start;
   
   -- Minimal möglicher Wert: 0.000000002
   WartezeitGrafik : constant Duration := 0.0002;
   -- Grafiktask
   
   
   
   -- Soundtask
   AktuelleMusik : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.SFML_Start;
   
   -- Minimal möglicher Wert: 0.000000002 
   WartezeitSound : constant Duration := 0.20;
   -- Soundtask
   
   procedure Leer;
   
private
   
   -- Den Zugriff auf die Interaktionsvariablen nur über Prozeduren und Funktionen erlauben?
   
   -- Logiktask
   
   -- Logiktask
   
   
   
   -- Grafiktask
   
   -- Grafiktask
   
   
   
   -- Soundtask
   
   -- Soundtask

end InteraktionTasks;
