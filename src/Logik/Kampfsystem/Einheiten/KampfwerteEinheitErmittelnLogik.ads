with SpeziesDatentypen;
with EinheitenRecords;
with KampfDatentypen;
with EinheitenKonstanten;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KampfwerteEinheitErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KampfDatentypen.KampfwerteGroß;
   
   function Gesamtverteidigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              ),
         
       Post => (
                  Gesamtverteidigung'Result >= 0
               );
   
   function Gesamtangriff
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              ),
         
       Post => (
                  Gesamtangriff'Result >= 0
               );
   
private
   
   Verschanzungsbonus : constant Float := 1.25;
   
   type GrundArray is array (Boolean'Range) of KampfDatentypen.KampfwerteEinheiten;
   Grundverteidigung : GrundArray;
   Grundangriff : GrundArray;
   
   type BonusArray is array (GrundArray'Range) of KampfDatentypen.KampfwerteAllgemein;
   Bonusverteidigung : BonusArray;
   Bonusangriff : BonusArray;
   
   type GesamtArray is array (GrundArray'Range) of KampfDatentypen.KampfwerteGroß;
   GesamteVerteidigung : GesamtArray;
   GesamterAngriff : GesamtArray;
   
   
   
   function Rangbonus
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KampfwertExtern : in KampfDatentypen.KampfwerteGroß)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 KampfwertExtern >= 0
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              ),
         
       Post => (
                  Rangbonus'Result >= 0
               );
     

end KampfwerteEinheitErmittelnLogik;
