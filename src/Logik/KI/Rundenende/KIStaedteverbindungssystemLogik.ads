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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   procedure ElementEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ElementExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
         
private
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   Leerwert : Boolean;
   TechnologieVorhanden : Boolean;
      
   VorhandenerWeg : KartenverbesserungDatentypen.Weg_Enum;

   Startgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   Zielgrund : KartengrundDatentypen.Basisgrund_Vorhanden_Enum;
   
   Stadtgrenze : StadtDatentypen.Städtebereich;
   
   BewertungPosition : Positive;
   
   KoordinatenAnfangsstadt : KartenRecords.KartenfeldNaturalRecord;
   KoordinatenEndstadt : KartenRecords.KartenfeldNaturalRecord;
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   KoordinatenzwischenspeicherWindows : KartenRecords.KartenfeldNaturalRecord;
   
   Sortieren : KartenRecords.BewegungsbewertungRecord;
   
   type BewertungArray is array (1 .. 9) of KartenRecords.BewegungsbewertungRecord;
   Bewertung : BewertungArray;
   
   procedure Felderbewertung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AktuelleKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 AktuelleKoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 AktuelleKoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 ZielkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 ZielkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   
   
   function VerbindungPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      StartkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 StartkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 StartkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 ZielkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 ZielkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function PlanenRekursiv
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AktuelleKoordinateExtern : in KartenRecords.KartenfeldNaturalRecord;
      ZielkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 AktuelleKoordinateExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 AktuelleKoordinateExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
               and
                 ZielkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 ZielkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function PlanschrittFestlegen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      ZielkoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 ZielkoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 ZielkoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function FeldUngeeignet
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function FelderMitWegEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function VerbindungLeeren
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIStaedteverbindungssystemLogik;
