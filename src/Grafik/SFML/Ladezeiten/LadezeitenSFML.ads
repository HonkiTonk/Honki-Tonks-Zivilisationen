pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with GrafikDatentypen;
private with LadezeitenDatentypen;
private with RassenDatentypen;

private with UmwandlungenAdaNachEigenes;

package LadezeitenSFML is
   
   procedure LadezeitenSFML
     (WelcheLadeanzeigeExtern : in GrafikDatentypen.Ladezeiten_Enum);

private
   
   WelcheZeit : Positive;
   
   ZeilenAbstand : Float;
   
   WelcheRasse : RassenDatentypen.Rassen_Enum;
         
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;
   
   procedure StandardsFestlegen;
   
   procedure SpielweltErstellen;
   procedure KIRechnet;
   procedure Rundenende;
   procedure SpeichernLaden;
   
   
   
   function ZahlAlsStringLadefortschritt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => LadezeitenDatentypen.Ladefortschritt);

end LadezeitenSFML;
