with KartenDatentypen;
with SpeziesDatentypen;
with KartenverbesserungDatentypen;
with KartengrundDatentypen;
with KartenRecords;
with EinheitenRecords;
with StadtRecords;
with WeltkarteRecords;
with KartenextraDatentypen;

with LeseWeltkarteneinstellungen;
with LeseSpeziesbelegung;

package SchreibeWeltkarte is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   
   procedure Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Zusatzgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure Gesamtgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrundExtern : in KartenRecords.KartengrundRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure Feldeffekt
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldeffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure AlleFeldeffekte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure Sichtbar
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      SichtbarExtern : in Boolean)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure GesamteSichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SichtbarkeitExtern : in KartenRecords.SichtbarkeitArray)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Fluss
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Ressource
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Weg
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure Verbesserung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   procedure BelegterGrund
     (KoordinatenExtern : KartenRecords.KartenfeldNaturalRecord;
      BelegterGrundExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure EinheitSchreiben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      EinheitentauschExtern : in Boolean)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure EinheitEntfernen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   procedure GanzerEintrag
     (EintragExtern : in WeltkarteRecords.WeltkarteRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   pragma Inline (GanzerEintrag);
   
   procedure Standardeinstellungen;
   pragma Inline (Standardeinstellungen);
   
end SchreibeWeltkarte;
