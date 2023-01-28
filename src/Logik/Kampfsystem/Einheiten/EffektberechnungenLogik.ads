with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

package EffektberechnungenLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Effektberechnungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenID;

end EffektberechnungenLogik;
