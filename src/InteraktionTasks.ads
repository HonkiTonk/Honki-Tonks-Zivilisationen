pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionTasks is

   -- Logiktask
   FensterErzeugt : Boolean := False;
   
   WartezeitLogik : constant Duration := 0.20;
   
   AktuelleRasse : SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse;
   -- Logiktask
   
   
   
   -- Grafiktask
   ErzeugeFenster : Boolean := False;
   FensterVerändert : Boolean := False;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe;
   
   AktuelleDarstellung : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.Grafik_SFML;
   
   WartezeitGrafik : constant Duration := 0.0002;
   -- Grafiktask
   
   
   
   -- Soundtask
   AktuelleMusik : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.Grafik_SFML;
   
   WartezeitSound : constant Duration := 0.20;
   -- Soundtask
   
   
   
   -- Allgemeines
   WartezeitMinimal : constant Duration := 0.000000002;
   
   -- Allgemeines
   
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
