pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with TextaccessVariablen;
with TextKonstanten;

with EinstellungenGrafik;
with ZeilenumbruchberechnungGrafik;
with RassenbeschreibungenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

package body ZusatztextRassenmenueGrafik is

   -- Hier dann später noch mehr Informationen über die Rassen einbauen. äöü
   function ZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive;
      AnzeigebereichbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      Textposition.x := TextKonstanten.StartpositionText.x;
      
      RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                         str  => ZeilenumbruchberechnungGrafik.ZeilenumbruchBerechnen (TextExtern   => RassenbeschreibungenGrafik.BeschreibungLang (RasseExtern => RasseAnzeigen),
                                                                                                       BreiteExtern => AnzeigebereichbreiteExtern));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen));
      
      Textposition.x := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                                                              TextbreiteExtern => 0.00);
      Textposition.y := Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand + TextberechnungenHoeheGrafik.NeueTexthöheErmitteln (TextAccessExtern => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                                                                                                                         TexthöheExtern  => 0.00);
      
      return Textposition;
      
   end ZusatztextRassenmenü;

end ZusatztextRassenmenueGrafik;
