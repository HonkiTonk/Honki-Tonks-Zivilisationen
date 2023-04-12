with SpeziesDatentypen;
with StadtDatentypen;
with StadtRecords;
with StadtKonstanten;

private with KartenRecords;
private with KartengrundDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;
private with KartenextraDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package GebaeudeanforderungenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function AnforderungenErfüllt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   
   Umgebungsgröße : KartenDatentypen.UmgebungsbereichDrei;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   -- Später dann noch um Zusatzgrund und Wege erweitern. äöü
   type UmgebungRecord is record
      
      Basisgrund : KartengrundDatentypen.Basisgrund_Enum;
      Zusatzgrund : KartengrundDatentypen.Zusatzgrund_Enum;
      Fluss : KartenextraDatentypen.Fluss_Enum;
      Ressource : KartenextraDatentypen.Ressourcen_Enum;
      Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
      Weg : KartenverbesserungDatentypen.Weg_Enum;
      
   end record;
   
   LeerUmgebung : constant UmgebungRecord := (
                                              Basisgrund   => KartengrundDatentypen.Leer_Basisgrund_Enum,
                                              Zusatzgrund  => KartengrundDatentypen.Leer_Zusatzgrund_Enum,
                                              Fluss        => KartenextraDatentypen.Leer_Fluss_Enum,
                                              Ressource    => KartenextraDatentypen.Leer_Ressource_Enum,
                                              Verbesserung => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                              Weg          => KartenverbesserungDatentypen.Leer_Weg_Enum
                                             );
   
   type UmgebungArray is array (KartenDatentypen.UmgebungsbereichDrei'Range, KartenDatentypen.UmgebungsbereichDrei'Range) of UmgebungRecord;
   Umgebung : UmgebungArray;
   
   -- Kann vermutlich weg, aber eventuell wird das noch woanders nützlich sein, mal nach KartenKonstanten oder so auslagern. äöü
   type FlussZuFlussartArray is array (KartenextraDatentypen.Fluss_Vorhanden_Enum'Range) of KartenextraDatentypen.Flussarten_Enum;
   FlussZuFlussart : constant FlussZuFlussartArray := (
                                                       KartenextraDatentypen.Fluss_Oberfläche_Enum'Range  => KartenextraDatentypen.Oberfläche_Fluss_Enum,
                                                       KartenextraDatentypen.Fluss_Unterfläche_Enum'Range => KartenextraDatentypen.Unterfläche_Fluss_Enum,
                                                       KartenextraDatentypen.Fluss_Kernfläche_Enum'Range  => KartenextraDatentypen.Kernfläche_Fluss_Enum
                                                      );
   
   procedure UmgebungDurchgehen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   
   
   function NotwendigeGebäudeVorhanden
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   -- Hier später noch einen Contracs einbauen um zu Prüfen dass immer wenigstens eins nicht Leer ist? äöü
   function UmgebungVorhanden
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum)
      return Boolean;
   
   function NotwendigeUmgebung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      GebäudeIDExtern : in StadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end GebaeudeanforderungenLogik;
