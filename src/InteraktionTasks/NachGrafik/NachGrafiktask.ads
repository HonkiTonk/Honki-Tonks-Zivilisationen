with Ada.Calendar; use Ada.Calendar;

with GrafikDatentypen;
with MenueDatentypen;
with EinheitenKonstanten;
with RassenDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;
with StadtDatentypen;
with ZahlenDatentypen;
with SystemDatentypen;
with SystemKonstanten;
with StadtRecords;
with SystemRecords;
with EinheitenRecords;
with KartenRecords;
with KartenRecordKonstanten;

-- Variablen mal nach Kategorien in Records sortieren.
package NachGrafiktask is
   
   -- Wird für Spielstart benötigt.
   ErzeugeFenster : Boolean := False;
   IntroAnzeigen : Boolean := True;
   
   -- Sprache
   MehrereSeiten : Boolean;
   
   Endauswahl : Natural;
   -- Wird für Spielstart benötigt.
   
   AktuelleDarstellung : GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum := GrafikDatentypen.Grafik_Start_Enum;
   
   FensterGeschlossen : Boolean := False;
   NameSpielstand : Boolean := False;
   
   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;
   
   KIRechnet : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   AktuelleRasse : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   KontaktierteRasse : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   
   AktuelleEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenKonstanten.LeerNummer;
   
   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert := StadtKonstanten.LeerNummer;
   
   FensterVerändert : GrafikDatentypen.Fenster_Ändern_Enum;
   
   -- Später erweitern mit nur Schriftgröße setzen, nur Schriftfarbe setzen, usw.. äöü
   AccesseSetzen : Boolean := False;
   
   Spielmeldung : SystemDatentypen.Spielmeldungen;
   StartzeitSpielmeldung : Time;

   TastenEingabe : Boolean := False;
   TextEingabe : Boolean := False;
   
   EingegebenesVorzeichen : Boolean := False;
   EingegebeneZahl : ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   
   AnzeigeFrage : ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   
   Eingabe : GrafikDatentypen.Welche_Eingabe_Enum := GrafikDatentypen.Keine_Eingabe_Enum;
   
   EinheitBewegt : Boolean := False;
   
   -- AktuelleAuswahl.AuswahlZwei wird auch bei JaNein verwendet, damit es sonst zu falschen Farbanzeigen kommen kann, wenn AuswahlEins bereits von einem Menü belegt wird, beispielsweise Speichern.
   AktuelleAuswahl : SystemRecords.MehrfacheAuswahlRecord := (SystemKonstanten.LeerAuswahl, SystemKonstanten.LeerAuswahl);
   SpeichernLaden : Boolean;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord := (False, (others => 0));
   
   AktuelleBauauswahl : StadtRecords.BauprojektRecord := (0, 0);
   
   GeheZu : KartenRecords.AchsenKartenfeldNaturalRecord := KartenRecordKonstanten.LeerKoordinate;
   
   Abspannart : GrafikDatentypen.Rassenhintergrund_Enum := GrafikDatentypen.Leer_Hintergrund_Enum;
   
   
   
   -- Editoren
   WelcherEditor : GrafikDatentypen.Editor_Enum;
   -- Editoren

end NachGrafiktask;
