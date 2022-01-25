pragma SPARK_Mode (On);

with SystemDatentypen;

package InteraktionMusiktask is

   AktuelleMusik : SystemDatentypen.Musik_Aktuelle_Auswahl_Enum := SystemDatentypen.Musik_SFML;
   
   procedure Leer;
   
end InteraktionMusiktask;
