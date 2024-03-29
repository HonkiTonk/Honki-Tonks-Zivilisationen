with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with StadtDatentypen;
private with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package StadtbausystemLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Bauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

private
   use type StadtDatentypen.GebäudeID;
   use type EinheitenDatentypen.EinheitenID;

   BauenMöglich : Boolean;

   AktuelleAuswahl : StadtRecords.ErweiterterBauprojektRecord := (0, 0, 0);
   NeuesBauprojekt : StadtRecords.BauprojektRecord;



   function MöglicheGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   function MöglicheEinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );



   function BauobjektAuswählen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return StadtRecords.BauprojektRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

   function AuswahlBauprojekt
     (AktuelleBauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtRecords.BauprojektRecord
     with
       Pre => (
               (if AktuelleBauprojektExtern.Gebäude /= 0 then AktuelleBauprojektExtern.Einheit = 0)
               and
                 (if AktuelleBauprojektExtern.Einheit /= 0 then AktuelleBauprojektExtern.Gebäude = 0)
              ),

       Post => (
                (if AuswahlBauprojekt'Result.Gebäude /= 0 then AuswahlBauprojekt'Result.Einheit = 0)
                and
                  (if AuswahlBauprojekt'Result.Einheit /= 0 then AuswahlBauprojekt'Result.Gebäude = 0)
               );

end StadtbausystemLogik;
