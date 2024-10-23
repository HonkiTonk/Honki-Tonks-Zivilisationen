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
      IDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
private
   use type KartengrundDatentypen.Basisgrund_Enum;
   use type KartengrundDatentypen.Zusatzgrund_Enum;
   use type KartenextraDatentypen.Fluss_Enum;
   use type KartenextraDatentypen.Ressourcen_Enum;
   use type KartenverbesserungDatentypen.Verbesserung_Enum;
   use type KartenverbesserungDatentypen.Weg_Enum;
   
   Stadtumgebung : KartenRecords.UmgebungDreiRecord;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   -- Den Record und die LeerUmgebung mal in Globales verschieben? äöü
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
   
   type UmgebungArray is array (KartenDatentypen.SenkrechteUmgebungDrei'Range, KartenDatentypen.WaagerechteUmgebungDrei'Range) of UmgebungRecord;
   Umgebung : UmgebungArray;
      
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
      GebäudeIDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
     with
       Pre => (
                 StadtSpeziesNummerExtern.Nummer in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function UmgebungVorhanden
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Enum;
      ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum)
      return Boolean
     with
       Pre => (
                 BasisgrundExtern /= KartengrundDatentypen.Leer_Basisgrund_Enum
               or
                 ZusatzgrundExtern /= KartengrundDatentypen.Leer_Zusatzgrund_Enum
               or
                 FlussExtern /= KartenextraDatentypen.Leer_Fluss_Enum
               or
                 RessourceExtern /= KartenextraDatentypen.Leer_Ressource_Enum
               or
                 VerbesserungExtern /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
               or
                 WegExtern /= KartenverbesserungDatentypen.Leer_Weg_Enum
              );
   
   function NotwendigeUmgebung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      GebäudeIDExtern : in StadtDatentypen.GebäudeIDVorhanden)
      return Boolean
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              );

end GebaeudeanforderungenLogik;
