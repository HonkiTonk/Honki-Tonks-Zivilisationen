pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;
with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with DatenbankRecords;
with EinheitenDatentypen;
with EinheitenRecords;

private with RueckgabeDatentypen;
private with DiplomatieDatentypen;

package DebugmenueLogik is

   -- Solche Sachen später in eine eigene ads Datei auslagern? äöü
   Alleskönner : constant DatenbankRecords.EinheitenlisteRecord := (
                                                                     EinheitArt              => EinheitenDatentypen.Cheat_Enum,
                                                                     PreisGeld               => 1,
                                                                     PreisRessourcen         => 1,
                                                                     PermanenteKosten        => (others => 0),
                                                                     Anforderungen           => -1,
                                                                     Passierbarkeit          => (others => True),
                                                                     MaximaleLebenspunkte    => 100,
                                                                     MaximaleBewegungspunkte => 100.00,
                                                                     WirdVerbessertZu        => 0,
                                                                     Beförderungsgrenze      => 1,
                                                                     MaximalerRang           => 100,
                                                                     Reichweite              => 100,
                                                                     Angriff                 => 100,
                                                                     Verteidigung            => 100,
                                                                     KannTransportieren      => EinheitenDatentypen.Gigantisch_Transport_Enum,
                                                                     KannTransportiertWerden => EinheitenDatentypen.Klein_Transport_Enum,
                                                                     Transportkapazität      => EinheitenRecords.TransporterArray'Last
                                                                    );

   procedure Debugmenü
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

private

   RückgabeDebugmenü : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   WelcherText : Positive;

   procedure KarteAufdecken
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

   procedure DiplomatischenStatusÄndern
     (NeuerStatusExtern : in DiplomatieDatentypen.Status_Untereinander_Enum);

   procedure LadezeitenAnzegien;

end DebugmenueLogik;
