pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with GrafikDatentypen;
with SpielVariablen;

private with LadezeitenDatentypen;

private with UmwandlungenAdaNachEigenes;

package LadezeitenSFML is
   
   -- Hier später passenden Contract einfügen. äöü
   procedure LadezeitenSFML
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Enum);

private
   
   WelcheZeit : Positive;
   
   AnfangspositionText : constant Float := 20.00;
         
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;
   
   procedure SpielweltErstellen;
   procedure Rundenende;
   procedure SpeichernLaden;
   
   procedure KIRechnet
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.KI_Spieler_Enum
              );
   
   
   
   function ZahlAlsStringLadefortschritt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => LadezeitenDatentypen.Ladefortschritt);

end LadezeitenSFML;
