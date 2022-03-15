pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package InteraktionMusiktask is

   AktuelleMusik : SystemDatentypen.Musik_Aktuelle_Auswahl_Enum := SystemDatentypen.Musik_SFML;
   
   procedure Leer;
   
end InteraktionMusiktask;
