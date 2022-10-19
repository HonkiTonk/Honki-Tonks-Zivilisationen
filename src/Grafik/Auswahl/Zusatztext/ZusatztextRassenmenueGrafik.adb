pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with TextaccessVariablen;

with EinstellungenGrafik;
with ZeilenumbruchberechnungGrafik;
with RassenbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;

package body ZusatztextRassenmenueGrafik is

   -- Hier dann später noch mehr Informationen über die Rassen einbauen. äöü
   function ZusatztextRassenmenü
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      
      RasseAnzeigen := RassenDatentypen.Rassen_Verwendet_Enum'Val (AktuelleAuswahlExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                         str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => RassenbeschreibungenGrafik.BeschreibungLang (RasseExtern => RasseAnzeigen),
                                                                                                        TextfeldbreiteExtern => (ViewflächeExtern.x / 2.00 - Textposition.x)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen));
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.RassenbeschreibungAccess (RasseAnzeigen),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      return Textposition;
      
   end ZusatztextRassenmenü;

end ZusatztextRassenmenueGrafik;
