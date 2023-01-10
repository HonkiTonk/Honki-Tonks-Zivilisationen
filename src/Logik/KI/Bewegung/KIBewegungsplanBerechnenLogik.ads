with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with KartenRecords;
private with EinheitenDatentypen;
private with KartenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package KIBewegungsplanBerechnenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function BewegungPlanen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
   use type KartenDatentypen.Kartenfeld;
   
   PlanungErfolgreich : Boolean;
   
   BewertungPosition : Positive;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
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
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
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
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
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
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
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
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function TransporterNutzen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
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
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIBewegungsplanBerechnenLogik;
