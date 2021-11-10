pragma SPARK_Mode (On);

with GlobaleTexte; use GlobaleTexte;
with SystemDatentypen;

package Auswahl is

   function Auswahl
     (FrageDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      TextDateiExtern : in GlobaleTexte.Welche_Datei_Enum;
      FrageZeileExtern : in Natural;
      ErsteZeileExtern : in Natural;
      LetzteZeileExtern : in Natural)
      return Integer
     with
       Pre =>
         (ErsteZeileExtern <= LetzteZeileExtern
          and
            (if FrageDateiExtern = GlobaleTexte.Leer then FrageZeileExtern = 0)
          and
            (if FrageZeileExtern = 0 then FrageDateiExtern = GlobaleTexte.Leer)
          and
            TextDateiExtern /= GlobaleTexte.Leer);

   function AuswahlJaNein
     (FrageZeileExtern : in Positive)
      return SystemDatentypen.Rückgabe_Werte_Enum;
   
private

   AktuelleAuswahl : Positive;
   
   Anfang : Natural;
   Ende : Natural;
   
end Auswahl;
