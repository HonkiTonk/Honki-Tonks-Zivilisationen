with SpeziesDatentypen;
with EinheitenDatentypen;

private with KartenRecords;
private with KartenDatentypen;
private with StadtDatentypen;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;

with LeseSpeziesbelegung;

private with LeseWeltkarteneinstellungen;

package KIStaedteverbindungssystemLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure Stadtverbindung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   procedure ElementEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ElementExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
         
private
   use type KartenDatentypen.Kartenfeld;
   
   Leerwert : Boolean;
   TechnologieVorhanden : Boolean;
      
   VorhandenerWeg : KartenverbesserungDatentypen.Weg_Enum;

   Startgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   Zielgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   
   Stadtgrenze : StadtDatentypen.MaximaleStädteMitNullWert;
   
   BewertungPosition : Positive;
   
   KoordinatenAnfangsstadt : KartenRecords.AchsenKartenfeldNaturalRecord;
   KoordinatenEndstadt : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KoordinatenzwischenspeicherWindows : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   Sortieren : KartenRecords.BewegungsbewertungRecord;
   
   type BewertungArray is array (1 .. 9) of KartenRecords.BewegungsbewertungRecord;
   Bewertung : BewertungArray;
   
   procedure Felderbewertung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 AktuelleKoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 ZielkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 ZielkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   
   
   function VerbindungPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StartkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 StartkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 StartkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 ZielkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 ZielkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function PlanenRekursiv
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AktuelleKoordinateExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 AktuelleKoordinateExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 AktuelleKoordinateExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
               and
                 ZielkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 ZielkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function PlanschrittFestlegen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 ZielkoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 ZielkoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function FeldUngeeignet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.YAchse <= LeseWeltkarteneinstellungen.YAchse
               and
                 KoordinatenExtern.XAchse <= LeseWeltkarteneinstellungen.XAchse
              );
   
   function FelderMitWegEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function VerbindungLeeren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIStaedteverbindungssystemLogik;
