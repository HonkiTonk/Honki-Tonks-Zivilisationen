with Ada.Calendar; use Ada.Calendar;

with GrafikDatentypen;
with MenueDatentypen;
with EinheitenKonstanten;
with StadtKonstanten;
with ZahlenDatentypen;
with KartenRecordKonstanten;
with SpeziesKonstanten;
with AuswahlKonstanten;
with SystemKonstanten;
with TaskRecords;

package Grafiktask is
   pragma Elaborate_Body;
   
   Grafik : TaskRecords.GrafikRecord := (
                                         FensterErzeugen     => False,
                                         IntroBeenden        => False,
                                         FensterEntfernen    => False,
                                         FensterAnpassen     => GrafikDatentypen.Keine_Änderung_Enum,
                                         Abspann             => GrafikDatentypen.Leer_Hintergrund_Enum
                                        );
   
   Texteinstellungen : TaskRecords.TexteinstellungenGrafikRecord := (others => False);
   
   Aktuell : TaskRecords.AktuellGrafikRecord := (
                                                 Darstellung         => GrafikDatentypen.Start_Enum,
                                                 Menü                => MenueDatentypen.Leer_Menü_Enum,
                                                 KIRechnet           => SpeziesKonstanten.LeerSpezies,
                                                 AktiveSpezies       => SpeziesKonstanten.LeerSpezies,
                                                 KontaktierteSpezies => SpeziesKonstanten.LeerSpezies,
                                                 Stadtnummer         => StadtKonstanten.LeerNummer,
                                                 Einheitnummer       => EinheitenKonstanten.LeerNummer,
                                                 GeheZu              => KartenRecordKonstanten.LeerKoordinate
                                                );
   
   -- Gesamtauswahl.Zweitauswahl wird auch bei JaNein verwendet, da es sonst zu falschen Farbanzeigen kommen kann wenn Erstauswahl bereits von einem Menü belegt wird, beispielsweise Speichern.
   Auswahl : TaskRecords.AuswahlGrafikRecord := (
                                                 Seitenauswahl       => False,
                                                 Löschauswahl        => False,
                                                 Endauswahl          => AuswahlKonstanten.LeerAuswahl,
                                                 Gesamtauswahl       => (AuswahlKonstanten.LeerAuswahl, AuswahlKonstanten.LeerAuswahl),
                                                 StadtEinheitAuswahl => (False, (others => AuswahlKonstanten.LeerStadtEinheitAuswahl)),
                                                 Bauauswahl          => (AuswahlKonstanten.LeerGebäudeauswahl, AuswahlKonstanten.LeerEinheitenauswahl)
                                                );
         
   Eingabe : TaskRecords.EingabeGrafikRecord := (
                                                 Tasteneingabe     => False,
                                                 Texteingabe       => False,
                                                 Vorzeicheneingabe => False,
                                                 Eingabeart        => GrafikDatentypen.Keine_Eingabe_Enum,
                                                 Zahleneingabe     => ZahlenDatentypen.EigenesNatural'First
                                                );
   
   Meldung : TaskRecords.MeldungGrafikRecord := (
                                                 Spielmeldung      => SystemKonstanten.LeerMeldung,
                                                 Spielmeldungszeit => Clock,
                                                 Fragenanzeige     => ZahlenDatentypen.EigenesNatural'First
                                                );
   
   Einheitenbewegung : TaskRecords.EinheitenbewegungGrafikRecord := (others => False);
   
   Spielstand : TaskRecords.SpielstandGrafikRecord := (others => False);
   
   
   
   Editor : TaskRecords.EditorGrafikRecord;

end Grafiktask;
