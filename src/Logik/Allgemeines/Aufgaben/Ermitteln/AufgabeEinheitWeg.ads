pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords;
with SpielVariablen;
with KartenRecords;

private with AufgabenDatentypen;
private with KartenVerbesserungDatentypen;
private with ProduktionDatentypen;

with Karten;

package AufgabeEinheitWeg is

   function WegErmitteln
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
     with
       Pre => (
                 KoordinatenExtern.YAchse <= Karten.Karteneinstellungen.Kartengröße.YAchse
               and
                 KoordinatenExtern.XAchse <= Karten.Karteneinstellungen.Kartengröße.XAchse
               and
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   WegVorhanden : KartenVerbesserungDatentypen.Karten_Weg_Enum;

   WelcherWeg : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   WelcheArbeit : AufgabenDatentypen.Einheiten_Aufgaben_Enum;

   Arbeitszeit : ProduktionDatentypen.ArbeitszeitVorhanden;

   Arbeitswerte : EinheitenRecords.ArbeitRecord;

   VorhandenerGrund : KartenRecords.KartengrundRecord;

   --------------------- Benutze ich das mehrmals und wenn ja, kann ich es zusammenführen?
   --------------------- Bräuchte ich hier aber in verschiedenen Ausführungen. Vermutlich sonnvoll die alles anzulegen aber wahrscheinlich nicht sie auszulagern.
   type WelcheWegartArray is array (KartenVerbesserungDatentypen.Karten_Weg_Enum'Range) of AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
   WelcheWegart : constant WelcheWegartArray := (
                                                 KartenVerbesserungDatentypen.Leer_Weg_Enum             => AufgabenDatentypen.Straße_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Straße_Enum'Range  => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Schiene_Enum'Range => AufgabenDatentypen.Schiene_Bauen_Enum,
                                                 KartenVerbesserungDatentypen.Karten_Tunnel_Enum'Range  => AufgabenDatentypen.Tunnel_Bauen_Enum
                                                );

   ----------------------------------- Noch rassenabhängig machen.
   type NötigteArbeitszeitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range, KartengrundDatentypen.Kartengrund_Arbeitszeit_Enum'Range) of ProduktionDatentypen.ArbeitszeitVorhanden;
   ------------------------------- Lava und Planetenkern berücksichtigen wenn ich später die Kerfläche einbaue.
   NötigteArbeitszeit : constant NötigteArbeitszeitArray := (
                                                               RassenDatentypen.Menschen_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Kasrodiah_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Lasupin_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Lamustra_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,

                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Manuky_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Suroka_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Pryolon_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Moru_Phisihl_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Larinos_Lotaris_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Carupex_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Alary_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Natries_Zermanis_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Tridatus_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Senelari_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Aspari_2_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Ekropa_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Tesorahn_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 ),

                                                               RassenDatentypen.Talbidahr_Enum =>
                                                                 (
                                                                  KartengrundDatentypen.Eis_Enum            => 5,
                                                                  KartengrundDatentypen.Wasser_Enum         => 5,
                                                                  KartengrundDatentypen.Küstengewässer_Enum => 2,
                                                                  KartengrundDatentypen.Flachland_Enum      => 2,
                                                                  KartengrundDatentypen.Wüste_Enum          => 5,
                                                                  KartengrundDatentypen.Hügel_Enum          => 3,
                                                                  KartengrundDatentypen.Gebirge_Enum        => 5,
                                                                  KartengrundDatentypen.Tundra_Enum         => 3,
                                                                  KartengrundDatentypen.Wald_Enum           => 3,
                                                                  KartengrundDatentypen.Dschungel_Enum      => 3,
                                                                  KartengrundDatentypen.Sumpf_Enum          => 3,
                                                                  KartengrundDatentypen.Untereis_Enum       => 5,
                                                                  KartengrundDatentypen.Küstengrund_Enum    => 2,
                                                                  KartengrundDatentypen.Meeresgrund_Enum    => 2,
                                                                  KartengrundDatentypen.Korallen_Enum       => 3,
                                                                  KartengrundDatentypen.Unterwald_Enum      => 3,
                                                                  KartengrundDatentypen.Erde_Enum           => 2,
                                                                  KartengrundDatentypen.Erdgestein_Enum     => 2,
                                                                  KartengrundDatentypen.Sand_Enum           => 2,
                                                                  KartengrundDatentypen.Gestein_Enum        => 5,
                                                                  KartengrundDatentypen.Lava_Enum           => 100,
                                                                  KartengrundDatentypen.Planetenkern_Enum   => 100,
                                                                  KartengrundDatentypen.Ringwoodit_Enum     => 2,
                                                                  KartengrundDatentypen.Majorit_Enum        => 2,
                                                                  KartengrundDatentypen.Perowskit_Enum      => 2,
                                                                  KartengrundDatentypen.Magnesiowüstit_Enum => 2
                                                                 )
                                                              );



   ------------------------------------ Über diese Contracts noch einmal nachdenken.
   function OberflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 (GrundExtern.BasisGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Eis_Enum)
               and
                 (GrundExtern.AktuellerGrund in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum'Range
                  or
                    GrundExtern.BasisGrund = KartengrundDatentypen.Eis_Enum)
              );

   function OberflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function UnterflächeLand
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   function UnterflächeWasser
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      WegExtern : in KartenVerbesserungDatentypen.Karten_Weg_Enum;
      GrundExtern : in KartenRecords.KartengrundRecord)
      return EinheitenRecords.ArbeitRecord
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );

   ----------------------- Später Wege für den Kern einbauen?

end AufgabeEinheitWeg;
