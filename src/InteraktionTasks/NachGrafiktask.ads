pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
with EinheitenRecords;

-- Variablen mal nach Kategorien in Records sortieren.
package NachGrafiktask is
   
   -- Wird für Spielstart benötigt.
   ErzeugeFenster : Boolean := False;
   
   -- Sprache
   MehrereSeiten : Boolean;
   
   Endauswahl : Natural;
   -- Wird für Spielstart benötigt.
   
   FensterGeschlossen : Boolean := False;
   NameSpielstand : Boolean := False;
   
   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;
   
   KIRechnet : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   AktuelleRasse : RassenDatentypen.Rassen_Enum := EinheitenKonstanten.LeerRasse;
   
   AktuelleEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenKonstanten.LeerNummer;
   
   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert := StadtKonstanten.LeerNummer;
   
   FensterVerändert : GrafikDatentypen.Fenster_Ändern_Enum;
   
   AktuelleDarstellung : GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum := GrafikDatentypen.Grafik_SFML_Enum;
   
   -- Später erweitern mit nur Schriftgröße setzen, nur Schriftfarbe setzen, usw.. äöü
   AccesseSetzen : Boolean := False;
   
   Spielmeldung : GrafikDatentypen.Spielmeldungen;
   StartzeitSpielmeldung : Time;

   TastenEingabe : Boolean := False;
   TextEingabe : Boolean := False;
   
   AnzeigeFrage : ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   
   Eingabe : SystemDatentypen.Welche_Eingabe_Enum := SystemDatentypen.Keine_Eingabe_Enum;
   
   AktuelleAuswahl : Integer := SystemKonstanten.LeerAuswahl;
   
   WelcheAuswahl : EinheitenRecords.AuswahlRecord := (False, (others => 0));
   
   AktuelleBauauswahl : StadtRecords.BauprojektRecord := (0, 0);

end NachGrafiktask;
