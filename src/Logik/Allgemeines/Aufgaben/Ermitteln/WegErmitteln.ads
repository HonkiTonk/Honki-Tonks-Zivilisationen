pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SonstigeVariablen;
with KartengrundDatentypen;
with SpielVariablen;
with AufgabenDatentypen;
with KartenVerbesserungDatentypen;
with ForschungenDatentypen;
with EinheitenDatentypen;

package WegErmitteln is

   function WegErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   WegVorhanden : KartenVerbesserungDatentypen.Karten_Weg_Enum;

   WelcherWeg : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   Grundzeit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := 1;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   --------------------- Benutze ich das mehrmals und wenn ja, kann ich es zusammenführen?
   --------------------- Bräuchte ich hier aber in verschiedenen Ausführungen. Vermutlich sonnvoll die alles anzulegen aber wahrscheinlich nicht sie auszulagern.
   type WelcheWegartArray is array (KartenVerbesserungDatentypen.Karten_Weg_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   WelcheWegart : constant WelcheWegartArray := (
                                                 KartenVerbesserungDatentypen.Leer_Weg_Enum             => AufgabenDatentypen.Straße_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Straße_Enum'Range  => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                                );

   ---------------------- Später mal auslagern, so dass das auch verädnerbar ist. RassenVariablen?
   type TechnologischeVoraussetzungArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, AufgabenDatentypen.Einheitenbefehle_Wege_Enum'Range) of ForschungenDatentypen.ForschungIDNichtMöglich;
   TechnologischeVoraussetzung : TechnologischeVoraussetzungArray := (
                                                                      RassenDatentypen.Menschen_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Kasrodiah_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Lasupin_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Lamustra_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Manuky_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Suroka_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Pryolon_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Moru_Phisihl_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Larinos_Lotaris_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Carupex_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Alary_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Natries_Zermanis_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Tridatus_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Senelari_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Aspari_2_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Ekropa_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                          RassenDatentypen.Tesorahn_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        ),

                                                                      RassenDatentypen.Talbidahr_Enum =>
                                                                        (
                                                                         AufgabenDatentypen.Straße_Bauen_Enum  => 0,
                                                                         AufgabenDatentypen.Schiene_Bauen_Enum => 10,
                                                                         AufgabenDatentypen.Tunnel_Bauen_Enum  => 20
                                                                        )
                                                                     );

   function OberflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Enum)
      return EinheitenRecords.ArbeitRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   function OberflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   function UnterflächeLand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Enum)
      return EinheitenRecords.ArbeitRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   function UnterflächeWasser
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum)
      return EinheitenRecords.ArbeitRecord
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

   ----------------------- Später Wege für den Kern einbauen?

end WegErmitteln;
