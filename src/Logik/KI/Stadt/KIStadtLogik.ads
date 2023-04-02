with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with EinheitenRecords;
private with KartenRecords;
private with EinheitenDatentypen;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with KIRecords;

package KIStadtLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure KIStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

private

   Umgebungsgröße : KartenDatentypen.UmgebungsbereichDrei;

   NotfallEinheit : EinheitenDatentypen.EinheitenIDMitNullWert;
   AktuelleEinheit : EinheitenDatentypen.EinheitenIDMitNullWert;

   FremdeEinheit : EinheitenRecords.SpeziesEinheitnummerRecord;

   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   StadtKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;

   procedure NeuesBauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitBauenExtern : in KIRecords.EinheitIDBewertungRecord;
      GebäudeBauenExtern : in KIRecords.GebäudeIDBewertungRecord;
      NotfallExtern : in Boolean)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );



   function GefahrStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

   function FeindNahe
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

   function WelcheEinheitArt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

   function NotfalleinheitBauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AktuelleEinheitExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      NächsteEinheitExtern : in EinheitenDatentypen.EinheitenID)
      return EinheitenDatentypen.EinheitenID
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIStadtLogik;
