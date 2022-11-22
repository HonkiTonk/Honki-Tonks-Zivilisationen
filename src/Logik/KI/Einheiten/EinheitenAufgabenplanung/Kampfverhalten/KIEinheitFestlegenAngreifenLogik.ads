with RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with KartenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitFestlegenAngreifenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   WenAngreifen : RassenDatentypen.Rassen_Enum;
   Ziel : RassenDatentypen.Rassen_Enum;
   
   KoordinatenFeind : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   
   
   function ZielErmitteln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Enum
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitFestlegenAngreifenLogik;
