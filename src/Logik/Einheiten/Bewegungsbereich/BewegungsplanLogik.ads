with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;
with KartenRecords;
with KartenDatentypen;
with StadtRecords;

private with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;
with LeseWeltkarteneinstellungen;

package BewegungsplanLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Kartenfeld;

   function BewegungPlanen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 ZielkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 ZielkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function Einzelschritt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   BewegungDurchführen : Boolean;
   
   AktuelleBewegungspunkte : EinheitenDatentypen.VorhandeneBewegungspunkte;
   
   BewertungPosition : Positive;
   
   StadtAufFeld : StadtRecords.SpeziesStadtnummerRecord;
   
   AndereEinheit : EinheitenRecords.SpeziesEinheitnummerRecord;
      
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   EinzelbewegungKartenwert : KartenRecords.AchsenKartenfeldNaturalRecord;
   EinheitenKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   NeueKoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   KeineÄnderung : constant KartenRecords.AchsenKartenfeldRecord := (0, 0, 0);
   
   type BewertungRecord is record
            
      Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
      
      Bewertung : KartenDatentypen.KartenfeldNatural;
      
   end record;
   
   Sortieren : BewertungRecord;
   
   type BewertungArray is array (1 .. 27) of BewertungRecord;
   Bewertung : BewertungArray;
   
   procedure Felderbewertung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AktuelleKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   
   
   function PlanenRekursiv
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 AktuelleKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function BewertungFeldposition
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 NeueKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 NeueKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function FeldBereitsBetreten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
         
   function PlanschrittFestlegen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end BewegungsplanLogik;
