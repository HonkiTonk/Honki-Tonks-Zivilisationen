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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
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
   
   Grundverteidigung : KampfDatentypen.KampfwerteEinheiten;
   Bonusverteidigung : KampfDatentypen.KampfwerteAllgemein;
   GesamteVerteidigung : KampfDatentypen.KampfwerteGroß;
   Grundangriff : KampfDatentypen.KampfwerteEinheiten;
   Bonusangriff : KampfDatentypen.KampfwerteAllgemein;
   GesamterAngriff : KampfDatentypen.KampfwerteGroß;
   
   Verschanzungsbonus : constant Float := 1.25;
   
   
   
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
