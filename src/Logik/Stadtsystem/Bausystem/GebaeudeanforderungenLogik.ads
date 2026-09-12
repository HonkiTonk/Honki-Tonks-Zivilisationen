with SpeziesDatentypen;
with StadtDatentypen;
with StadtRecords;
with StadtKonstanten;

private with KartenRecords;
private with KartenzusatzgrundDatentypen;
private with KartenverbesserungDatentypen;
private with KartenDatentypen;
private with KartenfluesseDatentypen;
private with KartenressourcenDatentypen;
private with KartenbasisgrundDatentypen;
private  with KartenwegeDatentypen;

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
   use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   use type KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
   use type KartenfluesseDatentypen.Fluss_Enum;
   use type KartenressourcenDatentypen.Ressourcen_Enum;
   use type KartenverbesserungDatentypen.Verbesserung_Enum;
   use type KartenwegeDatentypen.Weg_Enum;
   
   Stadtumgebung : KartenRecords.UmgebungDreiRecord;
   
   KartenWert : KartenRecords.KartenfeldNaturalRecord;
   Stadtkoordinaten : KartenRecords.KartenfeldNaturalRecord;
   
   -- Den Record und die LeerUmgebung mal in Globales verschieben? äöü
   type UmgebungRecord is record
      
      Basisgrund : KartenbasisgrundDatentypen.Basisgrund_Enum;
      Zusatzgrund : KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
      Fluss : KartenfluesseDatentypen.Fluss_Enum;
      Ressource : KartenressourcenDatentypen.Ressourcen_Enum;
      Verbesserung : KartenverbesserungDatentypen.Verbesserung_Enum;
      Weg : KartenwegeDatentypen.Weg_Enum;
      
   end record;
   
   LeerUmgebung : constant UmgebungRecord := (
                                              Basisgrund   => KartenbasisgrundDatentypen.Leer_Basisgrund_Enum,
                                              Zusatzgrund  => KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum,
                                              Fluss        => KartenfluesseDatentypen.Leer_Fluss_Enum,
                                              Ressource    => KartenressourcenDatentypen.Leer_Ressource_Enum,
                                              Verbesserung => KartenverbesserungDatentypen.Leer_Verbesserung_Enum,
                                              Weg          => KartenwegeDatentypen.Leer_Weg_Enum
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
     (BasisgrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Enum;
      ZusatzgrundExtern : in KartenzusatzgrundDatentypen.Zusatzgrund_Enum;
      FlussExtern : in KartenfluesseDatentypen.Fluss_Enum;
      RessourceExtern : in KartenressourcenDatentypen.Ressourcen_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      WegExtern : in KartenwegeDatentypen.Weg_Enum)
      return Boolean
     with
       Pre => (
                 BasisgrundExtern /= KartenbasisgrundDatentypen.Leer_Basisgrund_Enum
               or
                 ZusatzgrundExtern /= KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum
               or
                 FlussExtern /= KartenfluesseDatentypen.Leer_Fluss_Enum
               or
                 RessourceExtern /= KartenressourcenDatentypen.Leer_Ressource_Enum
               or
                 VerbesserungExtern /= KartenverbesserungDatentypen.Leer_Verbesserung_Enum
               or
                 WegExtern /= KartenwegeDatentypen.Leer_Weg_Enum
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
