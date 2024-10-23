with SpeziesDatentypen;
with KartenDatentypen;
with KartenRecords;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with StadtRecords;
with EinheitenRecords;
with WeltkarteRecords;
with StadtKonstanten;
with KartenextraDatentypen;
with StadtDatentypen;

with LeseWeltkarteneinstellungen;
with LeseGrenzen;
with LeseSpeziesbelegung;

package LeseWeltkarte is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KartenDatentypen.Senkrechte;
   use type KartenDatentypen.Waagerechte;
   use type SpeziesDatentypen.Spezies_Enum;
   use type StadtDatentypen.Städtebereich;
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartengrundDatentypen.Basisgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function Zusatzgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartengrundDatentypen.Zusatzgrund_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Gesamtgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.KartengrundRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Effekt
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      WelcherEffektExtern : in KartenextraDatentypen.Effekt_Kartenfeld_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Feldeffekte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.FeldeffektArray
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function Sichtbar
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function GesamteSichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.SichtbarkeitArray
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function Fluss
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenextraDatentypen.Fluss_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function Weg
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Weg_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function Verbesserung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenverbesserungDatentypen.Verbesserung_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function Ressource
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenextraDatentypen.Ressourcen_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );

   function BelegterGrund
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function UnbelegterGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function StadtbelegungGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              ),
         
       Post => (
                  if StadtbelegungGrund'Result.Spezies /= SpeziesDatentypen.Leer_Spezies_Enum then
                    (StadtbelegungGrund'Result.Nummer <= LeseGrenzen.Städtegrenzen (StadtbelegungGrund'Result.Spezies)
                     and
                       LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtbelegungGrund'Result.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum)
               );
   
   function BestimmteStadtBelegtGrund
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function SpeziesBelegtGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return SpeziesDatentypen.Spezies_Enum
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   
   function EinheitenbelegungGrund
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return EinheitenRecords.SpeziesEinheitnummerRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
      
   function GanzerEintrag
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
      return WeltkarteRecords.WeltkarteRecord
     with
       Pre => (
                 KoordinatenExtern.Senkrechte <= LeseWeltkarteneinstellungen.Senkrechte
               and
                 KoordinatenExtern.Waagerechte <= LeseWeltkarteneinstellungen.Waagerechte
              );
   pragma Inline (GanzerEintrag);

end LeseWeltkarte;
