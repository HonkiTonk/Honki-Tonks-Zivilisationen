with SpeziesDatentypen;
with EinheitenRecords;
with KampfDatentypen;
with EinheitenKonstanten;
with SystemDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package KampfwerteEinheitErmittelnLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spezies_Enum;
   use type SpeziesDatentypen.Spieler_Enum;
   use type KampfDatentypen.Kampfwerte;
   
   function Gesamtverteidigung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.Kampfwerte
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
      TaskExtern : in SystemDatentypen.Task_Enum)
      return KampfDatentypen.Kampfwerte
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
   
   Verschanzungsbonus : constant KampfDatentypen.Kampfbonus := 1.25;
   
   FehlendeHeimatstadtMalus : constant KampfDatentypen.KampfwerteEinheiten := 2;
   
   type GesamtArray is array (SystemDatentypen.Task_Enum'Range) of KampfDatentypen.Kampfwerte;
   Verteidigung : GesamtArray;
   Angriff : GesamtArray;

end KampfwerteEinheitErmittelnLogik;
