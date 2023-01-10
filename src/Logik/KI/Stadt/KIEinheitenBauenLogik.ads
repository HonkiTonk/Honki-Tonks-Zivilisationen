with SpeziesDatentypen;
with StadtRecords;
with StadtKonstanten;

private with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

with KIRecords;

private with KIDatentypen;

package KIEinheitenBauenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   function EinheitenBauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KIRecords.EinheitIDBewertungRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
private
         
   Gesamtwertung : KIDatentypen.BauenBewertung;
   Einheitwertung : KIDatentypen.BauenBewertung;
   AnzahlPassierbarkeiten : KIDatentypen.BauenBewertung;
   
   MengeVorhanden : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   MengeImBau : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   MinimaleSiedlerMenge : constant EinheitenDatentypen.MaximaleEinheiten := 2;
   AnzahlStädte : EinheitenDatentypen.MaximaleEinheiten;
   
   VorhandeneEinheiten : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   EinheitBewertet : KIRecords.EinheitIDBewertungRecord;
   
   
   
   function EinheitBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function ArbeiterBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function NahkämpferBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function FernkämpferBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function HerstellungskostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
     
   function GeldKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function NahrungKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
     
   function RessourcenKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function EinheitenDurchgehen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return KIRecords.EinheitIDBewertungRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function SpezielleEinheitBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIEinheitenBauenLogik;
