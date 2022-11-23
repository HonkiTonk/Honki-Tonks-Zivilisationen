with RassenDatentypen;
with EinheitenKonstanten;
with EinheitenRecords;

private with StadtDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package KISiedleraufgabenLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Rassen_Enum;
   use type RassenDatentypen.Spieler_Enum;

   procedure KISiedleraufgabenLogik
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

private

   VorhandeneStädte : StadtDatentypen.MaximaleStädteMitNullWert;

end KISiedleraufgabenLogik;
