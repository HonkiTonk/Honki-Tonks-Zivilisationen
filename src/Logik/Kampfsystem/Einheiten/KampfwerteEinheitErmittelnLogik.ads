with RassenDatentypen;
with EinheitenRecords;
with KampfDatentypen;
with EinheitenKonstanten;

with LeseGrenzen;
with LeseRassenbelegung;

package KampfwerteEinheitErmittelnLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;
   use type KampfDatentypen.KampfwerteGroß;
   
   function Gesamtverteidigung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
              ),
         
       Post => (
                  Gesamtverteidigung'Result >= 0
               );
   
   function Gesamtangriff
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KampfwertExtern : in KampfDatentypen.KampfwerteGroß)
      return KampfDatentypen.KampfwerteGroß
     with
       Pre => (
                 KampfwertExtern >= 0
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
              ),
         
       Post => (
                  Rangbonus'Result >= 0
               );
     

end KampfwerteEinheitErmittelnLogik;
