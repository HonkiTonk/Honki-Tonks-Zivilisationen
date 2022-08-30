pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with TextaccessVariablen;
with TextKonstanten;

with GrafikEinstellungenSFML;
with BeschreibungenZeilenumbruchSFML;
with RassenbeschreibungenSFML;
with TextberechnungenBreiteSFML;
with TextberechnungenHoeheSFML;

package body AnzeigeZusatztextRassenmenueSFML is

   -- Hier dann später noch mehr Informationen über die Rassen einbauen. äöü
   function AnzeigeZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive;
      AnzeigebereichbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textposition.y := TextberechnungenHoeheSFML.Zeilenabstand;
      Textposition.x := TextKonstanten.StartpositionText.x;
      
      RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                         str  => BeschreibungenZeilenumbruchSFML.ZeilenumbruchBerechnen (TextExtern   => RassenbeschreibungenSFML.BeschreibungLang (RasseExtern => RasseAnzeigen),
                                                                                                         BreiteExtern => AnzeigebereichbreiteExtern));
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                         text         => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen));
      
      Textposition.x := TextberechnungenBreiteSFML.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                                                            TextbreiteExtern => 0.00);
      Textposition.y := Textposition.y + TextberechnungenHoeheSFML.Zeilenabstand + TextberechnungenHoeheSFML.NeueTexthöheErmitteln (TextAccessExtern => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                                                                                                                     TexthöheExtern  => 0.00);
      
      return Textposition;
      
   end AnzeigeZusatztextRassenmenü;

end AnzeigeZusatztextRassenmenueSFML;
