with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with KartenRecords;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KIBewegungsplanVereinfachenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Planvereinfachung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   procedure BewegungsplanVerschieben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   NächsterSchritt : constant EinheitenDatentypen.BewegungsplanVorhanden := 1;
   ÜbernächsterSchritt : constant EinheitenDatentypen.BewegungsplanVorhanden := 2;
   Zusatzschritt : EinheitenDatentypen.BewegungsplanVorhanden;
   
   Planschritt : EinheitenDatentypen.Bewegungsplan;
      
   KartenwertVereinfachung : KartenRecords.AchsenKartenfeldNaturalRecord;
   AktuellePlankoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure PlanvereinfachungPrüfen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   
   
   function Verschieben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end KIBewegungsplanVereinfachenLogik;
