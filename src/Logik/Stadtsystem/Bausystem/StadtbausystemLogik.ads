with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with KartenRecords;
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
   use type StadtDatentypen.GebäudeIDMitNullwert;
   use type EinheitenDatentypen.EinheitenIDMitNullWert;

   GebäudeBaubar : Boolean;
   EinheitenBaubar : Boolean;
   BauenMöglich : Boolean;

   WasGebautWerdenSoll : Natural;
   Befehl : Natural;

   Zeilenabstand : Float;

   AktuelleAuswahl : StadtRecords.BauprojektRecord := (0, 0);
   AktuellesBauprojekt : StadtRecords.BauprojektRecord;
   NeuesBauprojekt : StadtRecords.BauprojektRecord;
   GewähltesBauprojekt : StadtRecords.BauprojektRecord;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;



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

   function AuswahlBauprojektSFML
     return StadtRecords.BauprojektRecord
     with
       Post => (
                (if AuswahlBauprojektSFML'Result.Gebäude /= 0 then AuswahlBauprojektSFML'Result.Einheit = 0)
                and
                  (if AuswahlBauprojektSFML'Result.Einheit /= 0 then AuswahlBauprojektSFML'Result.Gebäude = 0)
               );

end StadtbausystemLogik;
