with EinheitenRecords;
with RassenDatentypen;
with EinheitenKonstanten;
with KartenDatentypen;

with LeseGrenzen;
with LeseRassenbelegung;

package EinheitenbewegungsbereichLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   type BewegungsbereichArray is array (KartenDatentypen.EbeneVorhanden'Range, KartenDatentypen.Bewegungsbereich'Range, KartenDatentypen.Bewegungsbereich'Range) of Boolean;
   Bewegungsbereich : BewegungsbereichArray := (others => (others => (others => False)));

   procedure BewegungsbereichBerechnen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => EinheitRasseNummerExtern.Rasse)
               and
                 LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
              );

end EinheitenbewegungsbereichLogik;
