pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;

package NachMusiktask is

   AktuelleMusik : TonDatentypen.Musik_Aktuelle_Auswahl_Enum := TonDatentypen.Musik_SFML_Enum;
   
end NachMusiktask;
