pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with LadezeitenDatentypen;
with RassenDatentypen;

with UmwandlungenAdaNachEigenes;

package LadezeitenSFML is

   procedure SpielweltErstellen;
   procedure KIRechnet;
   procedure ZwischenDenRunden;

private
   
   WelcheZeit : Positive;
   
   ZeilenAbstand : Float;
   
   WelcheRasse : RassenDatentypen.Rassen_Enum;
         
   AktuelleTextposition : Sf.System.Vector2.sfVector2f;
   
   function ZahlAlsStringLadefortschritt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => LadezeitenDatentypen.Ladefortschritt);

end LadezeitenSFML;
