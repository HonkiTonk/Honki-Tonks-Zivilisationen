pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;

package InteraktionMusiktask is

   AktuelleMusik : GrafikTonDatentypen.Musik_Aktuelle_Auswahl_Enum := GrafikTonDatentypen.Musik_SFML_Enum;
   
   procedure Leer;
   
end InteraktionMusiktask;
