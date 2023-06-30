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
   
   Spielstart : TaskRecords.SpielstartGrafikRecord := (others => False);
   
   Grafik : TaskRecords.GrafikRecord := (
                                         FensterGeschlossen  => False,
                                         AktuelleDarstellung => GrafikDatentypen.Start_Enum,
                                         AktuellesMenü       => MenueDatentypen.Leer_Menü_Enum,
                                         FensterVerändert    => GrafikDatentypen.Keine_Änderung_Enum,
                                         Abspannart          => GrafikDatentypen.Leer_Hintergrund_Enum
                                        );
   
   Aktuelles : TaskRecords.AktuellesGrafikRecord := (
                                                     Stadtkarte          => False,
      
                                                     KIRechnet           => SpeziesKonstanten.LeerSpezies,
                                                     AktuelleSpezies     => SpeziesKonstanten.LeerSpezies,
                                                     KontaktierteSpezies => SpeziesKonstanten.LeerSpezies,
      
                                                     AktuelleStadt       => StadtKonstanten.LeerNummer,
   
                                                     AktuelleEinheit     => EinheitenKonstanten.LeerNummer,
   
                                                     GeheZu              => KartenRecordKonstanten.LeerKoordinate
                                                    );
   
   Texteinstellungen : TaskRecords.TexteinstellungenGrafikRecord := (others => False);
   
   Meldungen : TaskRecords.MeldungenGrafikRecord := (
                                                     Spielmeldung          => SystemKonstanten.LeerMeldung,
                                                     StartzeitSpielmeldung => Clock,
                                                     AnzeigeFrage          => ZahlenDatentypen.EigenesNatural'First
                                                    );
         
   Eingaben : TaskRecords.EingabeGrafikRecord := (
                                                  TastenEingabe     => False,
                                                  TextEingabe       => False,
                                                  VorzeichenEingabe => False,
                                                  Eingabeart        => GrafikDatentypen.Keine_Eingabe_Enum,
                                                  ZahlenEingabe     => ZahlenDatentypen.EigenesNatural'First
                                                 );
   
   Einheitenbewegung : TaskRecords.EinheitenbewegungGrafikRecord := (others => False);
   
   Spielstand : TaskRecords.SpielstandGrafikRecord := (others => False);
   
   -- AktuelleAuswahl.AuswahlZwei wird auch bei JaNein verwendet, damit es sonst zu falschen Farbanzeigen kommen kann, wenn AuswahlEins bereits von einem Menü belegt wird, beispielsweise Speichern.
   Auswahl : TaskRecords.AuswahlGrafikRecord := (
                                                 SprachenSeitenauswahl => False,
                                                 LöschenAuswahl        => False,
                                                 Endauswahl            => AuswahlKonstanten.LeerAuswahl,
                                                 AktuelleAuswahl       => (AuswahlKonstanten.LeerAuswahl, AuswahlKonstanten.LeerAuswahl),
                                                 StadtEinheitAuswahl   => (False, (others => AuswahlKonstanten.LeerStadtEinheitAuswahl)),
                                                 Bauauswahl            => (AuswahlKonstanten.LeerGebäudeauswahl, AuswahlKonstanten.LeerEinheitenauswahl)
                                                );
   
   
   
   -- Editoren
   Editoren : TaskRecords.EditorGrafikRecord;
   -- Editoren

end Grafiktask;
