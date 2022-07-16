pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with MenueDatentypen;
with EinheitenKonstanten;
with RassenDatentypen;
with EinheitenDatentypen;
with StadtKonstanten;
with StadtDatentypen;

package InteraktionGrafiktask is
   
   FensterGeschlossen : Boolean := False;
   NameSpielstand : Boolean := False;
   
   KIRechnet : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   
   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;
   
   AktuelleRasse : RassenDatentypen.Rassen_Enum := EinheitenKonstanten.LeerRasse;
   
   AktuelleEinheit : EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenKonstanten.LeerNummer;
   
   AktuelleStadt : StadtDatentypen.MaximaleStädteMitNullWert := StadtKonstanten.LeerNummer;
   
   type Fenster_Ändern_Enum is (
                                 Keine_Änderung_Enum,
                                 
                                 Bildrate_Ändern_Enum, Fenster_Verändert_Enum, Auflösung_Verändert_Enum, Modus_Verändert_Enum
                                );
   
   subtype Fenster_Wurde_Verändert_Enum is Fenster_Ändern_Enum range Fenster_Verändert_Enum .. Modus_Verändert_Enum;
   
   FensterVerändert : Fenster_Ändern_Enum;
   
   AktuelleDarstellung : GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum := GrafikDatentypen.Grafik_SFML_Enum;

end InteraktionGrafiktask;
