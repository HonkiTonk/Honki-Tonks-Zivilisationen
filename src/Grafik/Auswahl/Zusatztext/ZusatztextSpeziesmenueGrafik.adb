with TextaccessVariablen;
with GrafikKonstanten;

with ZeilenumbruchberechnungGrafik;
with SpeziesbeschreibungenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextaccessverwaltungssystemGrafik;

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
      
      TextaccessverwaltungssystemGrafik.TextPositionZeichnen (TextaccessExtern => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen),
                                                              TextExtern       => ZeilenumbruchberechnungGrafik.Zeilenumbruchberechnung
                                                                (TextExtern           => SpeziesbeschreibungenGrafik.Langbeschreibung (SpeziesExtern => SpeziesAnzeigen),
                                                                 TextfeldbreiteExtern => (ViewflächeExtern.x / GrafikKonstanten.Halbierung - Textposition.x)),
                                                              PositionExtern   => Textposition);
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      TextAccessExtern => TextaccessVariablen.SpeziesbeschreibungAccess (SpeziesAnzeigen),
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
      
      return Textposition;
      
   end ZusatztextSpeziesmenü;

end ZusatztextSpeziesmenueGrafik;
