with RassenDatentypen;
with StadtRecords;
with StadtKonstanten;

private with SystemRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package StadtAllgemeinesLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure NeuerStadtname
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
     with
       Pre => (
                 StadtRasseNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => StadtRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   NeuerName : SystemRecords.TextEingabeRecord;

end StadtAllgemeinesLogik;
