with Ada.Calendar; use Ada.Calendar;

with GrafikDatentypen;
with MenueDatentypen;
with EinheitenKonstanten;
with SpeziesDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;
with StadtDatentypen;
with ZahlenDatentypen;
with StadtRecords;
with SystemRecords;
with EinheitenRecords;
with KartenRecords;
with KartenRecordKonstanten;
with SpeziesKonstanten;
with AuswahlKonstanten;
with SystemKonstanten;
with TextnummernKonstanten;
with GrafikRecords;

-- Variablen mal nach Kategorien in Records sortieren und in thematische Dateien mit eigenem Zugriff ordnen? äöü
package NachGrafiktask is
   pragma Elaborate_Body;
   
   -- Wird für Spielstart benötigt.
   ErzeugeFenster : Boolean := False;
   IntroAnzeigen : Boolean := True;
   
   -- Sprache
   MehrereSeiten : Boolean := False;
   LöschenAusgewählt : Boolean := False;
   
   Endauswahl : Natural := AuswahlKonstanten.LeerAuswahl;
   -- Wird für Spielstart benötigt.
   
   AktuelleDarstellung : GrafikDatentypen.AKtuelle_Anzeige_Enum := GrafikDatentypen.Start_Enum;
   
   FensterGeschlossen : Boolean := False;
   NameSpielstand : Boolean := False;
   
   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;
   
   KIRechnet : SpeziesDatentypen.Spezies_Enum := SpeziesKonstanten.LeerSpezies;
   AktuelleSpezies : SpeziesDatentypen.Spezies_Enum := SpeziesKonstanten.LeerSpezies;
   KontaktierteSpezies : SpeziesDatentypen.Spezies_Enum := SpeziesKonstanten.LeerSpezies;
   
   AktuelleEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenKonstanten.LeerNummer;
   
   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert := StadtKonstanten.LeerNummer;
   Stadtkarte : Boolean := False;
   
   FensterVerändert : GrafikDatentypen.Fenster_Ändern_Enum := GrafikDatentypen.Keine_Änderung_Enum;
   
   Texteinstellungen : GrafikRecords.TexteinstellungenRecord := (others => False);
   
   Spielmeldung : TextnummernKonstanten.Spielmeldungen := SystemKonstanten.LeerMeldung;
   StartzeitSpielmeldung : Time;
   
   Eingaben : GrafikRecords.EingabeRecord;

   TastenEingabe : Boolean := False;
   TextEingabe : Boolean := False;
   
   EingegebenesVorzeichen : Boolean := False;
   EingegebeneZahl : ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   
   AnzeigeFrage : ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   
   Eingabe : GrafikDatentypen.Eingabe_Enum := GrafikDatentypen.Keine_Eingabe_Enum;
   
   EinheitBewegt : Boolean := False;
   Einheitenbewegung : Boolean := False;
   EinheitBewegungsbereich : Boolean := False;
   
   -- AktuelleAuswahl.AuswahlZwei wird auch bei JaNein verwendet, damit es sonst zu falschen Farbanzeigen kommen kann, wenn AuswahlEins bereits von einem Menü belegt wird, beispielsweise Speichern.
   AktuelleAuswahl : SystemRecords.MehrfacheAuswahlRecord := (AuswahlKonstanten.LeerAuswahl, AuswahlKonstanten.LeerAuswahl);
   SpeichernLaden : Boolean := False;
   
   StadtEinheitAuswahl : EinheitenRecords.AuswahlRecord := (False, (others => AuswahlKonstanten.LeerStadtEinheitAuswahl));
   
   AktuelleBauauswahl : StadtRecords.BauprojektRecord := (AuswahlKonstanten.LeerGebäudeauswahl, AuswahlKonstanten.LeerEinheitenauswahl);
   
   GeheZu : KartenRecords.AchsenKartenfeldNaturalRecord := KartenRecordKonstanten.LeerKoordinate;
   
   Abspannart : GrafikDatentypen.Spezieshintergrund_Enum := GrafikDatentypen.Leer_Hintergrund_Enum;
   
   
   
   -- Editoren
   WelcherEditor : GrafikDatentypen.Editor_Enum;
   -- Editoren

end NachGrafiktask;
