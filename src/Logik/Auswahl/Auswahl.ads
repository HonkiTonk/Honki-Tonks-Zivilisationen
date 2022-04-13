pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- with GlobaleTexte; use GlobaleTexte;
with SystemDatentypen;

package Auswahl is

   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;
   
private

   AktuelleAuswahl : Positive;
   
   Anfang : Natural;
   Ende : Natural;
   
end Auswahl;
