with Sf.Graphics.Text;

with TextaccessVariablen;
with GrafikKonstanten;

with ZeilenumbruchberechnungGrafik;
with SpeziesbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body ZusatztextSpeziesmenueGrafik is

   -- Hier dann später noch mehr Informationen über die Spezies einbauen. äöü
   function ZusatztextSpeziesmenü
     (AktuelleAuswahlExtern : in Positive;
      ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
            
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      
      SpeziesAnzeigen := SpeziesDatentypen.Spezies_Vorhanden_Enum'Val (AktuelleAuswahlExtern);
      
      TextaccessverwaltungssystemEinfachGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen),
                                                                     TextExtern       => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung (TextExtern           => SpeziesbeschreibungenGrafik.Langbeschreibung
                                                                                                                                                (SpeziesExtern => SpeziesAnzeigen),
                                                                                                                                                TextfeldbreiteExtern => ViewflächeExtern.x,
                                                                                                                                                BreitenabzugExtern   => GrafikKonstanten.Verdreifachung * Textposition.x),
                                                                     PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextpositionOhneTexthöhe (PositionExtern   => Textposition.y,
                                                                                   ZusatzwertExtern => Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen)).height);
      
      -- Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
      --                                                                 ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
      
      return Textposition;
      
   end ZusatztextSpeziesmenü;

end ZusatztextSpeziesmenueGrafik;
