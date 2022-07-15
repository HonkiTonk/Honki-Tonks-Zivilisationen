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
      
   WelcheRasse : RassenDatentypen.Rassen_Enum;
   
   AnfangspositionText : constant Float := 20.00;
         
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;
   
   procedure SpielweltErstellen;
   procedure KIRechnet;
   procedure Rundenende;
   procedure SpeichernLaden;
   
   
   
   function ZahlAlsStringLadefortschritt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => LadezeitenDatentypen.Ladefortschritt);

end LadezeitenSFML;
