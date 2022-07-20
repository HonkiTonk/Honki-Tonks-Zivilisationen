pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with MenueDatentypen;
with EinheitenKonstanten;
with RassenDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;
with StadtDatentypen;

-- Alle Entfernen (auch in den anderen Dateien), dann entsprechend den Fehlermeldungen folgend alles neu aufbauen in entsprechenden Dateien? äöü
package NachGrafiktask is
   
   -- Wird für Spielstart benötigt.
   ErzeugeFenster : Boolean := False;
   -- Wird für Spielstart benötigt.
   
   FensterGeschlossen : Boolean := False;
   NameSpielstand : Boolean := False;
   
   KIRechnet : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   
   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;
   
   AktuelleRasse : RassenDatentypen.Rassen_Enum := EinheitenKonstanten.LeerRasse;
   
   AktuelleEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenKonstanten.LeerNummer;
   
   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert := StadtKonstanten.LeerNummer;
   
   FensterVerändert : GrafikDatentypen.Fenster_Ändern_Enum;
   
   AktuelleDarstellung : GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum := GrafikDatentypen.Grafik_SFML_Enum;

end NachGrafiktask;
