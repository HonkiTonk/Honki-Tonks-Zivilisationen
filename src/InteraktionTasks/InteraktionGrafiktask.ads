pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikDatentypen;
with MenueDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;
with RassenDatentypen;

package InteraktionGrafiktask is
   
   FensterGeschlossen : Boolean := False;
   NameSpielstand : Boolean := False;
   
   KIRechnet : RassenDatentypen.Rassen_Enum := RassenDatentypen.Keine_Rasse_Enum;
   
   AktuellesMenü : MenueDatentypen.Welches_Menü_Enum := MenueDatentypen.Leer_Menü_Enum;
   
   AktuelleRasseEinheit : EinheitenRecords.RasseEinheitnummerRecord := EinheitenKonstanten.LeerRasseNummer;
   
   type Fenster_Ändern_Enum is (
                                 Keine_Änderung_Enum,
                                 
                                 Bildrate_Ändern_Enum, Fenster_Verändert_Enum, Auflösung_Verändert_Enum, Modus_Verändert_Enum
                                );
   
   subtype Fenster_Wurde_Verändert_Enum is Fenster_Ändern_Enum range Fenster_Verändert_Enum .. Modus_Verändert_Enum;
   subtype Fenster_Unverändert_Enum is Fenster_Ändern_Enum range Keine_Änderung_Enum .. Bildrate_Ändern_Enum;
   
   FensterVerändert : Fenster_Ändern_Enum;
   
   AktuelleDarstellung : GrafikDatentypen.Grafik_Aktuelle_Darstellung_Enum := GrafikDatentypen.Grafik_SFML_Enum;

end InteraktionGrafiktask;
