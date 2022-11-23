with RassenDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

with LeseGrenzen;
with LeseRassenbelegung;

package KIEinheitUmsetzenAngriffskriegLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   function AngriffskriegVorbereiten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitUmsetzenAngriffskriegLogik;
