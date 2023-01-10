with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with TextaccessVariablen;

with EinstellungenGrafik;
with ZeilenumbruchberechnungGrafik;
with SpeziesbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;

package body ZusatztextSpeziesmenueGrafik is

   -- Hier dann später noch mehr Informationen über die Spezies einbauen. äöü
   function ZusatztextSpeziesmenü
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      
      SpeziesAnzeigen := SpeziesDatentypen.Spezies_Verwendet_Enum'Val (AktuelleAuswahlExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen),
                                         str  => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => SpeziesbeschreibungenGrafik.Langbeschreibung (SpeziesExtern => SpeziesAnzeigen),
                                                                                                        TextfeldbreiteExtern => (ViewflächeExtern.x / 2.00 - Textposition.x)));
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen),
                                    position => Textposition);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen));
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      return Textposition;
      
   end ZusatztextSpeziesmenü;

end ZusatztextSpeziesmenueGrafik;
