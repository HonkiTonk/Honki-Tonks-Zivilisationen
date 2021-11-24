pragma SPARK_Mode (On);

with SystemDatentypen;

package SoundWichtigeEinstellungen is

   AktuelleMusik : SystemDatentypen.Grafik_Aktuelle_Darstellung_Enum := SystemDatentypen.SFML_Start;
   
   -- Minimal möglicher Wert: 0.000000002 
   Wartezeit : constant Duration := 0.20;

end SoundWichtigeEinstellungen;
