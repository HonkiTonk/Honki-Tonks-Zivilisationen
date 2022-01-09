pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionSoundtask is
   
   procedure AktuelleMusikÄndern
     (MusikExtern : in SystemDatentypen.Musik_Aktuelle_Auswahl_Enum);
   
   
   
   function AktuelleMusikAbfragen
     return SystemDatentypen.Musik_Aktuelle_Auswahl_Enum;
   
private

   AktuelleMusik : SystemDatentypen.Musik_Aktuelle_Auswahl_Enum := SystemDatentypen.Musik_SFML;

end InteraktionSoundtask;
