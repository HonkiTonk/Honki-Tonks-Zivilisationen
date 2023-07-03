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
   
   MengeVorhanden : EinheitenDatentypen.Einheitenbereich;
   MengeImBau : EinheitenDatentypen.Einheitenbereich;
   
   MinimaleSiedlerMenge : constant EinheitenDatentypen.EinheitenbereichVorhanden := 2;
   AnzahlStädte : EinheitenDatentypen.EinheitenbereichVorhanden;
   
   VorhandeneEinheiten : EinheitenDatentypen.Einheitenbereich;
   
   EinheitBewertet : KIRecords.EinheitIDBewertungRecord;
   
   
   
   -- Theoretisch könnte man StädteanzahlExtern noch mit einem Contracts prüfen ob es <= Städtegrenzen ist, muss dann aber immer eine Umwandlung enthalten, da der Datentype ja bei Einheiten ist. äöü
   function EinheitBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      StädteanzahlExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function ArbeiterBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function NahkämpferBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      StädteanzahlExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function FernkämpferBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      StädteanzahlExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function HerstellungskostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
     
   function GeldKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function NahrungKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
     
   function RessourcenKostenBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function EinheitenDurchgehen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      StädteanzahlExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KIRecords.EinheitIDBewertungRecord
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );
   
   function SpezielleEinheitBewerten
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      StädteanzahlExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
      return KIDatentypen.BauenBewertung
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) = SpeziesDatentypen.KI_Spieler_Enum
              );

end KIEinheitenBauenLogik;
