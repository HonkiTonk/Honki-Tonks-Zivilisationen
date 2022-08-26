pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with StadtDatentypen; use StadtDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with ForschungenDatentypen;
with StadtRecords;
with MenueDatentypen;
with SystemRecords;

-- Später alles auf Natural umschreiben und die einzelnen Auswahlen zusammenführen? äöü
package Mausauswahl is

   function RassenauswahlDiplomatie
     return Natural;
   
   function Forschungsmenü
     return ForschungenDatentypen.ForschungIDMitNullWert;

   function Baumenü
     return StadtRecords.BauprojektRecord
     with
       Post => (
                (if Baumenü'Result.Gebäude /= 0 then Baumenü'Result.Einheit = 0)
                and
                  (if Baumenü'Result.Einheit /= 0 then Baumenü'Result.Gebäude = 0)
               );
   
   function Menüs
     (WelchesMenüExtern : in MenueDatentypen.Welches_Menü_Vorhanden_Enum;
      AnfangExtern : in Positive;
      EndeExtern : in Positive)
      return Natural;
   
   function JaNein
     return Natural;
   
   function Steuerung
     return SystemRecords.MehrfacheAuswahlRecord;
   
private
   
   Mausposition : Sf.System.Vector2.sfVector2f;

end Mausauswahl;
