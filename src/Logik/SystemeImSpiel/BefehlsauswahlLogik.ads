pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with RueckgabeDatentypen;

private with TastenbelegungDatentypen;
private with StadtRecords;

package BefehlsauswahlLogik is

   function Befehlsauswahl
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Befehl : TastenbelegungDatentypen.Tastenbelegung_Enum;
   
   StadtSuchenNachNamen : StadtRecords.RasseStadtnummerRecord;
   
   
   
   function Tasteneingabe
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Tastenbelegung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

end BefehlsauswahlLogik;
