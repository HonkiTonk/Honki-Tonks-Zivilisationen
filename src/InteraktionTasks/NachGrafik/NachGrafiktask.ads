with Ada.Calendar; use Ada.Calendar;

with GrafikDatentypen;
with MenueDatentypen;
with EinheitenKonstanten;
with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;
with StadtDatentypen;
with ZahlenDatentypen;
with KartenRecords;
with KartenRecordKonstanten;
with SpeziesKonstanten;
with AuswahlKonstanten;
with SystemKonstanten;
with TextnummernKonstanten;
with TaskRecords;

-- Variablen mal nach Kategorien in Records sortieren und in thematische Dateien mit eigenem Zugriff ordnen? äöü
package NachGrafiktask is
   pragma Elaborate_Body;
   
   Spielstart : TaskRecords.SpielstartRecord := (others => False);
   
   Grafik : TaskRecords.GrafikRecord := (
                                         FensterGeschlossen  => False,
                                         AktuelleDarstellung => GrafikDatentypen.Start_Enum,
                                         AktuellesMenü       => MenueDatentypen.Leer_Menü_Enum,
                                         FensterVerändert    => GrafikDatentypen.Keine_Änderung_Enum,
                                         Abspannart          => GrafikDatentypen.Leer_Hintergrund_Enum
                                        );
   
   KIRechnet : SpeziesDatentypen.Spezies_Enum := SpeziesKonstanten.LeerSpezies;
   AktuelleSpezies : SpeziesDatentypen.Spezies_Enum := SpeziesKonstanten.LeerSpezies;
   KontaktierteSpezies : SpeziesDatentypen.Spezies_Enum := SpeziesKonstanten.LeerSpezies;
   
   AktuelleEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenKonstanten.LeerNummer;
   
   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert := StadtKonstanten.LeerNummer;
   Stadtkarte : Boolean := False;
   
   Texteinstellungen : TaskRecords.TexteinstellungenRecord := (others => False);
   
   Spielmeldung : TextnummernKonstanten.Spielmeldungen := SystemKonstanten.LeerMeldung;
   StartzeitSpielmeldung : Time;
      
   Eingaben : TaskRecords.EingabeRecord := (
                                            TastenEingabe     => False,
                                            TextEingabe       => False,
                                            VorzeichenEingabe => False,
                                            Eingabeart        => GrafikDatentypen.Keine_Eingabe_Enum,
                                            ZahlenEingabe     => ZahlenDatentypen.EigenesNatural'First
                                           );
     
   AnzeigeFrage : ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   
   Einheitenbewegung : TaskRecords.EinheitenbewegungRecord := (others => False);
   
   Spielstand : TaskRecords.SpielstandRecord := (others => False);
   
   -- AktuelleAuswahl.AuswahlZwei wird auch bei JaNein verwendet, damit es sonst zu falschen Farbanzeigen kommen kann, wenn AuswahlEins bereits von einem Menü belegt wird, beispielsweise Speichern.
   Auswahl : TaskRecords.AuswahlRecord := (
                                           SprachenSeitenauswahl => False,
                                           LöschenAuswahl        => False,
                                           Endauswahl            => AuswahlKonstanten.LeerAuswahl,
                                           AktuelleAuswahl       => (AuswahlKonstanten.LeerAuswahl, AuswahlKonstanten.LeerAuswahl),
                                           StadtEinheitAuswahl   => (False, (others => AuswahlKonstanten.LeerStadtEinheitAuswahl)),
                                           Bauauswahl            => (AuswahlKonstanten.LeerGebäudeauswahl, AuswahlKonstanten.LeerEinheitenauswahl)
                                          );
   
   GeheZu : KartenRecords.AchsenKartenfeldNaturalRecord := KartenRecordKonstanten.LeerKoordinate;
   
   
   
   -- Editoren
   Editoren : TaskRecords.EditorRecord;
   -- Editoren

end NachGrafiktask;
